# frozen_string_literal: true

require "scint/parallel_fetcher"
require "scint/materializer"

module Gemset2Nix
  module Commands
    class Fetch
      def run(argv)
        @project = project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: gemset2nix fetch [options] [gemset files...]"
            $stderr.puts "  -j, --jobs N    Parallel downloads (default: 20, env: JOBS)"
            exit 0
          end
        end

        inputs = if argv.empty?
          Dir.glob(File.join(project.gemsets_dir, "*.gemset"))
        else
          argv.flat_map { |a| resolve_inputs(a) }
        end

        if inputs.empty?
          UI.fail "No .gemset files found. Run 'gemset2nix import' first."
          exit 1
        end

        # Parse all lockfiles and classify specs via Materializer
        mat = project.materializer
        all_classified = inputs.map { |f| mat.classify(project.parse_lockfile(f)) }

        rubygems = all_classified.flat_map { |c| c[:rubygems] }.uniq { |g| "#{g[:name]}-#{g[:version]}" }
        git_repos = {}
        all_classified.each do |c|
          c[:git].each { |key, repo| git_repos[key] ||= repo }
        end

        UI.header "Fetch"
        UI.info "#{rubygems.size + git_repos.values.sum { |r| r[:gems].size }} gems " \
                "#{UI.dim("(#{rubygems.size} rubygems, #{git_repos.size} git repos)")}"

        # ── Git repos ─────────────────────────────────────────────────

        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Git repos")
          git_repos.each_value do |repo|
            ok = mat.materialize_git(repo)
            progress.advance(success: ok)
          end
          progress.finish
        end

        # ── Rubygems (parallel fetch + materialize) ───────────────────

        if rubygems.any?
          # Filter already-materialized gems
          needed = rubygems.reject { |g| mat.materialized?(g[:name], g[:version]) }
          skipped = rubygems.size - needed.size

          if needed.empty?
            UI.done "#{rubygems.size} rubygems (all cached)"
          else
            progress = UI::Progress.new(rubygems.size, label: "Rubygems")
            skipped.times { progress.advance(skip: true) }

            fetcher = Scint::ParallelFetcher.new(
              concurrency: jobs,
              dest_dir: project.gem_cache_dir
            )

            items = needed.map { |g| { name: g[:name], version: g[:version], source_uri: "https://rubygems.org/" } }

            fetcher.fetch_gems(items) do |result|
              if result[:error]
                progress.advance(success: false)
              else
                # Materialize: extract source + metadata
                ok = mat.materialize_gem(result[:path], result[:name], result[:version])
                progress.advance(success: ok)
              end
            end

            fetcher.close
            progress.finish
          end
        end
      end

      private

      def resolve_inputs(arg)
        if File.directory?(arg)
          Dir.glob(File.join(arg, "*.gemset"))
        elsif File.file?(arg)
          [arg]
        else
          UI.warn "Not found: #{arg}"
          []
        end
      end
    end
  end
end
