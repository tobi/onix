# frozen_string_literal: true

require_relative "build"

module Onix
  module Commands
    class Hydrate < Build
      def run(argv)
        @project = Project.new
        @keep_going = false
        @rsync_available = nil
        @skip_if_unchanged = true
        target = nil

        while argv.first&.start_with?("-")
          option = argv.shift
          case option
          when "--keep-going", "-k"
            @keep_going = true
          when "--target"
            target = argv.shift
            if target.nil? || target.empty?
              UI.fail "--target requires a path"
              exit 1
            end
          when "--force"
            @skip_if_unchanged = false
          when "--help", "-h"
            $stderr.puts "Usage: onix hydrate [options] <project> [target]"
            $stderr.puts "  onix hydrate myapp /path/to/app   # build node_modules and hydrate target"
            $stderr.puts "  onix hydrate myapp                # hydrate to lockfile directory"
            $stderr.puts "  --target PATH                     hydrate target directory"
            $stderr.puts "  --force                           rehydrate even when marker is unchanged"
            $stderr.puts "  -k, --keep-going                  continue past failures"
            exit 0
          else
            UI.fail "Unknown option: #{option}"
            exit 1
          end
        end

        project = argv.shift
        target ||= argv.shift
        if project.nil? || project.empty? || argv.any?
          UI.fail "Usage: onix hydrate [options] <project> [target]"
          exit 1
        end

        unless project_has_node?(project)
          UI.fail "Project '#{project}' has no node packages."
          exit 1
        end

        target ||= lockfile_dir_for_project(project)
        if target.nil? || target.empty?
          UI.fail "No hydrate target for '#{project}'. Pass --target PATH or set lockfile_path metadata."
          exit 1
        end

        UI.header "Hydrate"
        UI.info "#{project} #{UI.dim("→ #{target}")}"
        if @skip_if_unchanged
          expected_identity = node_modules_identity_from_project(project)
          if expected_identity.nil? || expected_identity.empty?
            UI.warn "Unable to evaluate node_modules identity; continuing with build"
          elsif node_modules_target_matches_identity?(target, expected_identity)
            UI.info "node_modules unchanged"
            return
          end
        end

        node_store_path = build_node_modules(project)
        return if node_store_path.nil? || node_store_path.empty?

        hydrate_node_modules(node_store_path, target_root: target, skip_if_unchanged: @skip_if_unchanged)
      end
    end
  end
end
