# frozen_string_literal: true

require "open3"

module Onix
  module Commands
    class Build
      HAS_NOM = system("which", "nom", out: File::NULL, err: File::NULL)
      TAIL_LINES = 50

      def run(argv)
        @project = Project.new
        @keep_going = false

        while argv.first&.start_with?("-")
          case argv.shift
          when "--keep-going", "-k" then @keep_going = true
          when "--help", "-h"
            $stderr.puts "Usage: onix build [options] [project] [gem]"
            $stderr.puts "  onix build                  # build all projects"
            $stderr.puts "  onix build myapp            # build all gems for myapp"
            $stderr.puts "  onix build myapp rack       # build one gem from myapp"
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
        nix_file = project_nix(project)
        UI.header "Build"
        UI.info "#{gem_name} #{UI.dim("from #{project}")}"

        cmd = ["nix-build", "--no-out-link", nix_file, "-A", gem_name]
        run_nix(cmd)
      end

      def build_project(project)
        nix_file = project_nix(project)
        UI.header "Build"
        UI.info project

        cmd = ["nix-build", "--no-out-link", nix_file, "-A", "bundlePath"]
        cmd << "--keep-going" if @keep_going
        run_nix(cmd)
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
        end
      end

      def project_nix(name)
        path = File.join(@project.nix_dir, "#{name}.nix")
        abort "No nix file for project '#{name}'. Run 'onix generate' first." unless File.exist?(path)
        path
      end

      def run_nix(cmd)
        t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        output_lines = []
        failed_drvs = []

        popen_args = if HAS_NOM
          shell = cmd.map { |a| shellescape(a) }.join(" ") + " 2>&1 | nom"
          ["bash", "-c", shell]
        else
          cmd
        end

        IO.popen(popen_args, err: [:child, :out]) do |io|
          io.set_encoding("UTF-8", invalid: :replace)
          io.each_line do |line|
            $stderr.print "  #{line}" if UI.tty? && !HAS_NOM
            output_lines << line
            stripped = line.strip

            case stripped
            when /error: builder for '([^']+)' failed/,
                 /error: Cannot build '([^']+)'/
              drv = $1
              name = drv_to_gem_name(drv)
              failed_drvs << { drv: drv, name: name } unless failed_drvs.any? { |f| f[:drv] == drv }
            end
          end
        end

        exit_status = $?
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
        built = output_lines.count { |l| l.strip.start_with?("/nix/store/") }

        $stderr.puts

        if failed_drvs.empty? && exit_status&.success?
          UI.done "#{built} built #{UI.dim(UI.format_time(elapsed))}"
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
            overlay_doc = File.expand_path("../../../docs/overlays.md", __dir__)
            $stderr.puts "  See #{UI.dim(overlay_doc)}"
          end
          print_tail(output_lines)
          exit 1 unless @keep_going
        end
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
        s.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/, '\\\\\\1')
      end

      def drv_to_gem_name(drv)
        basename = drv.sub(%r{.*/[a-z0-9]*-}, "").sub(/\.drv$/, "")
        basename.sub(/-[0-9][0-9.]*$/, "")
      end
    end
  end
end
