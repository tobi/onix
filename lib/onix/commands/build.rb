# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require_relative "../packageset"
require_relative "../pnpm/credentials"

module Onix
  module Commands
    class Build
      HAS_NOM = system("which", "nom", out: File::NULL, err: File::NULL)
      TAIL_LINES = 50

      def run(argv)
        @project = Project.new
        @keep_going = false
        @rsync_available = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--keep-going", "-k" then @keep_going = true
          when "--help", "-h"
            $stderr.puts "Usage: onix build [options] [project] [gem]"
            $stderr.puts "  onix build                  # build all projects"
            $stderr.puts "  onix build myapp            # build all gems for myapp"
            $stderr.puts "  onix build myapp rack       # build one gem from myapp"
            $stderr.puts "  onix build myapp node       # build node_modules for myapp"
            $stderr.puts "  -k, --keep-going            continue past failures"
            exit 0
          end
        end

        case argv.size
        when 0 then build_all
        when 1 then build_project(argv[0])
        when 2 then build_gem(argv[0], argv[1])
        end
      end

      private

      def build_gem(project, gem_name)
        if node_modules_target?(gem_name)
          build_node_modules(project, skip_if_unchanged: false)
          return
        end

        nix_file = project_nix(project)
        UI.header "Build"
        UI.info "#{gem_name} #{UI.dim("from #{project}") }"
        run_nix(["nix-build", "--no-out-link", nix_file, "-A", gem_name])
      end

      def build_project(project)
        nix_file = project_nix(project)
        UI.header "Build"
        UI.info project
        cmd = ["nix-build", "--no-out-link", nix_file, "-A", "bundlePath"]
        cmd << "--keep-going" if @keep_going
        run_nix(cmd)

        if project_has_node?(project)
          build_node_modules(project, skip_if_unchanged: true)
        end
      end

      def build_all
        projects = @project.packageset_names
        if projects.empty?
          UI.fail "No packagesets. Run 'onix import' first."
          exit 1
        end

        UI.header "Build"
        UI.info "#{projects.size} projects"

        projects.each do |name|
          nix_file = project_nix(name)
          next unless File.exist?(nix_file)

          UI.info "#{UI.bold(name)}"
          cmd = ["nix-build", "--no-out-link", nix_file, "-A", "bundlePath"]
          cmd << "--keep-going" if @keep_going
          run_nix(cmd)

          if project_has_node?(name)
            build_node_modules(name, skip_if_unchanged: true)
          end
        end
      end

      def build_node_modules(project, skip_if_unchanged: true)
        nix_file = project_nix(project)
        cmd = ["nix-build", "--no-out-link", nix_file, "-A", "nodeModules"]
        cmd << "--keep-going" if @keep_going
        node_env = pnpm_build_env
        node_store_path = run_nix(cmd, return_paths: true, env: node_env)
        return if node_store_path.nil? || node_store_path.empty?

        hydrate_node_modules(node_store_path, skip_if_unchanged: skip_if_unchanged)
      end

      def project_nix(name)
        path = File.join(@project.nix_dir, "#{name}.nix")
        abort "No nix file for project '#{name}'. Run 'onix generate' first." unless File.exist?(path)
        path
      end

      def run_nix(cmd, return_paths: false, env: {})
        t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        if return_paths
          cmd = cmd.dup
          cmd.delete("--no-out-link")
        end

        if HAS_NOM && !return_paths && env.empty?
          run_nix_with_nom(cmd, t0, env)
          return
        end

        out_link = nil
        output = if return_paths
          Dir.mktmpdir("onix-build-") do |tmpdir|
            out_link = File.join(tmpdir, "result")
            cmd << "--out-link"
            cmd << out_link
            run_nix_direct(cmd, t0, out_link: out_link, env: env, return_paths: true)
          end
        else
          run_nix_direct(cmd, t0, env: env)
        end

        output if return_paths
      end

      # nom needs a real TTY to render its TUI. We pipe nix stderr to nom,
      # and tee stdout to capture store paths + errors.
      def run_nix_with_nom(cmd, t0, env)
        # nom reads nix's stderr (build progress). stdout (store paths) goes to terminal.
        # --no-idle-warning suppresses "nom hasn't detected any input" when everything is cached.
        shell = cmd.map { |a| shellescape(a) }.join(" ") + " 2> >(nom 2>/dev/null)"
        env_prefix = env.empty? ? nil : env.map { |k, v| "#{k}=#{shellescape(v)}" }.join(" ")
        shell = [env_prefix, shell].compact.join(" ")
        $stderr.puts
        success = system("bash", "-c", shell)
        $stderr.puts
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0

        if success
          UI.done "built #{UI.dim(UI.format_time(elapsed))}"
        else
          UI.fail "build failed #{UI.dim(UI.format_time(elapsed))}"
          $stderr.puts
          $stderr.puts "  Re-run without nom for detailed errors:"
          $stderr.puts "  #{UI.dim(cmd.join(" "))}"
          exit 1 unless @keep_going
        end
      end

      # Without nom: capture output, parse errors, show progress
      def run_nix_direct(cmd, t0, out_link: nil, return_paths: false, env: {})
        output_lines = []
        failed_drvs = []
        built_paths = []

        IO.popen(env, cmd, err: [:child, :out]) do |io|
          io.set_encoding("UTF-8", invalid: :replace)
          io.each_line do |line|
            $stderr.print "  #{line}" if UI.tty?
            output_lines << line
            stripped = line.strip

            case stripped
            when /error: builder for '([^']+)' failed/,
                 /error: Cannot build '([^']+)'/
              drv = $1
              name = drv_to_gem_name(drv)
              failed_drvs << { drv: drv, name: name } unless failed_drvs.any? { |f| f[:drv] == drv }
            end

            if stripped.start_with?("/nix/store/")
              built_paths << stripped.split(/\s+/).first
            end
          end
        end

        exit_status = $?
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
        built = output_lines.count { |l| l.strip.start_with?("/nix/store/") }

        $stderr.puts

        if failed_drvs.empty? && exit_status&.success?
          UI.done "#{built} built #{UI.dim(UI.format_time(elapsed))}"
          return read_out_link(out_link) if return_paths
          return built_paths.first
        else
          UI.fail "#{built} built, #{UI.red("#{failed_drvs.size} failed")} #{UI.dim(UI.format_time(elapsed))}"
          $stderr.puts
          failed_drvs.each do |f|
            overlay = File.join(@project.overlays_dir, "#{f[:name]}.nix")
            hint = File.exist?(overlay) ? "edit overlays/#{f[:name]}.nix" : "create overlays/#{f[:name]}.nix"
            UI.fail "#{f[:name]}  #{UI.dim("→")}  #{hint}"
            UI.step UI.dim("nix log #{f[:drv]}")
          end
          if failed_drvs.any?
            $stderr.puts
            $stderr.puts "  See #{UI.dim("docs/overlays.md")}"
          end
          print_tail(output_lines)
          exit 1 unless @keep_going
        end
      end

      def node_modules_target?(name)
        ["node", "nodeModules", "node_modules", "nodemodules"].include?(name)
      end

      def project_has_node?(project)
        path = File.join(@project.packagesets_dir, "#{project}.jsonl")
        return false unless File.exist?(path)

        _, entries = Packageset.read(path)
        entries.any? { |e| e.installer == "node" }
      end

      def hydrate_node_modules(store_path, skip_if_unchanged: false)
        source = File.join(store_path, "node_modules")
        id = node_modules_id(store_path)
        target = File.join(@project.root, "node_modules")
        id_file = File.join(@project.root, ".node_modules_id")

        unless Dir.exist?(source)
          UI.fail "node_modules derivation missing node_modules output at #{source}"
          exit 1 unless @keep_going
          return
        end

        FileUtils.mkdir_p(File.dirname(id_file))

        if skip_if_unchanged && File.exist?(id_file) && File.read(id_file).strip == id
          UI.info "node_modules unchanged"
          return
        end

        if rsync_available?
          success = system("rsync", "-a", "--chmod=Du+rwx,Fu+rwX", "--delete", "#{source}/", "#{target}/")
          unless success
            UI.fail "rsync failed while hydrating #{target}"
            exit 1 unless @keep_going
            return
          end
        else
          FileUtils.rm_rf(target)
          FileUtils.mkdir_p(target)
          entries = Dir.glob("#{source}/*", File::FNM_DOTMATCH) +
                    Dir.glob("#{source}/.*", File::FNM_DOTMATCH)
          entries.reject! { |entry| ["#{source}/.", "#{source}/.."].include?(entry) }
          entries.each { |entry| FileUtils.cp_r(entry, target, preserve: true) }
        end

        FileUtils.chmod_R(0o755, target)
        File.write(id_file, id)
        UI.done "hydrated node_modules from #{store_path}"
      end

      def node_modules_id(store_path)
        marker = File.join(store_path, ".node_modules_id")
        return File.read(marker).strip if File.exist?(marker)
        store_path
      end

      def rsync_available?
        @rsync_available = system("which", "rsync", out: File::NULL, err: File::NULL) if @rsync_available.nil?
        @rsync_available
      end

      def pnpm_build_env
        token_lines = Pnpm::Credentials.token_lines(@project.root)
        env = {}
        env["ONIX_NPM_TOKEN_LINES"] = token_lines.join("\n") unless token_lines.empty?

        %w[
          SSL_CERT_FILE
          NODE_EXTRA_CA_CERTS
          NODE_TLS_REJECT_UNAUTHORIZED
        ].each do |name|
          value = ENV[name]
          env[name] = value if value && !value.empty?
        end

        env
      end

      def read_out_link(out_link)
        return nil unless out_link
        File.realpath(out_link)
      rescue Errno::ENOENT, Errno::EINVAL
        nil
      end

      def print_tail(output_lines)
        tail = output_lines.last(TAIL_LINES)
        return if tail.empty?
        $stderr.puts
        $stderr.puts UI.dim("  ── last #{tail.size} lines ──")
        tail.each { |l| $stderr.puts UI.dim("  #{l.rstrip}") }
      end

      def shellescape(s)
        return "''" if s.empty?
        s.gsub(/([^A-Za-z0-9_\-.,:\/\@\n])/, '\\\\1')
      end

      def drv_to_gem_name(drv)
        basename = drv.sub(%r{.*/[a-z0-9]*-}, "").sub(/\.drv$/, "")
        basename.sub(/-[0-9][0-9.]*$/, "")
      end
    end
  end
end
