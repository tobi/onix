# frozen_string_literal: true

require "json"
require "yaml"

module Onix
  module Pnpm
    class ProjectConfig
      attr_reader :package_manager, :root

      def initialize(root)
        @root = File.expand_path(root)
      end

      def package_manager=(value)
        @package_manager = parse_package_manager(value)
      end

      def package_manager
        return @package_manager if defined?(@package_manager)
        @package_manager = detect_package_manager
      end

      def package_manager_major
        return nil unless package_manager
        package_manager.match(/@(\d+)/)&.[](1)&.to_i
      end

      def node_version_major
        package_json = File.join(@root, "package.json")
        return nil unless File.exist?(package_json)

        engines = JSON.parse(File.read(package_json))["engines"]
        return nil unless engines.is_a?(Hash)

        parse_major(engines["node"])
      rescue JSON::ParserError
        nil
      rescue StandardError
        nil
      end

      def script_policy
        if scripts_configured?
          "allowed"
        else
          "none"
        end
      end

      def enforce_manager_compatible_with(lockfile_version)
        return if package_manager_major.nil?

        lockfile_major = parse_major(lockfile_version)
        return if lockfile_major.nil?
        return if package_manager_major >= lockfile_major

        raise ArgumentError,
              "packageManager #{package_manager} is older than pnpm lockfileVersion #{lockfile_version} " \
              "(requires major >= #{lockfile_major})"
      end

      private

      def detect_package_manager
        package_json = File.join(@root, "package.json")
        return nil unless File.exist?(package_json)

        JSON.parse(File.read(package_json))["packageManager"]
      rescue JSON::ParserError
        nil
      rescue StandardError
        nil
      end

      def scripts_configured?
        data = load_workspace_yaml
        return false if data.empty?

        only_built = data["onlyBuiltDependencies"]
        ignored = data["ignoredBuiltDependencies"]
        (only_built && !only_built.empty?) || (ignored && !ignored.empty?)
      end

      def load_workspace_yaml
        workspace = File.join(@root, "pnpm-workspace.yaml")
        return {} unless File.exist?(workspace)

        YAML.safe_load(File.read(workspace), permitted_classes: [Array, Hash, String, Integer, TrueClass, FalseClass, NilClass]) || {}
      rescue StandardError
        {}
      end

      def parse_package_manager(value)
        return nil if value.nil?
        raw = value.to_s.strip
        return nil if raw.empty?

        raw.match?(/pnpm@\d+/i) ? raw : nil
      end

      def parse_major(value)
        match = value.to_s.match(/(\d+)/)
        match ? match[1].to_i : nil
      end
    end
  end
end
