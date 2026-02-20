# frozen_string_literal: true

require_relative "../packageset"

module Onix
  module Commands
    class Backfill
      def run(argv)
        @project = Project.new

        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix backfill"
            $stderr.puts "Backfills packageset metadata (lockfile_path)."
            exit 0
          end
        end

        UI.header "Backfill"
        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        if packagesets.empty?
          UI.info "no packagesets"
          return
        end

        updated = 0
        unchanged = 0
        unresolved = 0

        packagesets.each do |path|
          project_name = File.basename(path, ".jsonl")
          meta, entries = Packageset.read(path)
          next if meta.nil?

          lockfile = resolve_lockfile(project_name, meta, entries)
          desired_lockfile_path = lockfile || meta.lockfile_path

          if desired_lockfile_path.nil?
            unresolved += 1
            next
          end

          if meta.lockfile_path == desired_lockfile_path
            unchanged += 1
            next
          end

          next_meta = Packageset::Meta.new(
            ruby: meta.ruby,
            bundler: meta.bundler,
            platforms: meta.platforms,
            package_manager: meta.package_manager,
            script_policy: meta.script_policy,
            lockfile_path: desired_lockfile_path,
            node_version_major: meta.node_version_major,
            pnpm_version_major: meta.pnpm_version_major,
          )

          Packageset.write(path, meta: next_meta, entries: entries)
          updated += 1
          UI.wrote "packagesets/#{project_name}.jsonl"
        end

        UI.info "#{updated} updated, #{unchanged} unchanged, #{unresolved} unresolved"
        UI.done "backfill complete"
      end

      private

      def resolve_lockfile(project_name, meta, entries)
        candidates = []
        candidates << lockfile_candidate(meta.lockfile_path) if present?(meta.lockfile_path)

        if entries.any? { |e| e.installer == "node" }
          candidates << File.join(@project.root, "pnpm-lock.yaml")
          candidates << File.join(@project.root, "#{project_name}/pnpm-lock.yaml")
          candidates << File.join(@project.root, "#{project_name}.pnpm-lock.yaml")
        end

        if entries.any? { |e| e.installer != "node" }
          candidates << File.join(@project.root, "Gemfile.lock")
          candidates << File.join(@project.root, "#{project_name}/Gemfile.lock")
        end

        candidates.compact.uniq.find { |candidate| File.file?(candidate) }
      end

      def lockfile_candidate(path)
        expanded = File.expand_path(path.to_s)
        expanded = File.realpath(expanded) if File.exist?(expanded)
        return expanded if path.to_s.start_with?("/")

        File.expand_path(path.to_s, @project.root)
      end

      def present?(value)
        !(value.nil? || value.empty?)
      end
    end
  end
end
