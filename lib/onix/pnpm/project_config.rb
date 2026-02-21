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

      def package_manager_version
        parse_package_manager_version(package_manager)
      end

      def pnpm_engine
        engines = package_json_engines
        return nil unless engines.is_a?(Hash)

        value = engines["pnpm"]
        return nil if value.nil?

        raw = value.to_s.strip
        raw.empty? ? nil : raw
      end

      def pnpm_engine_exact_version
        value = pnpm_engine
        return nil if value.nil?
        return value if exact_version?(value)

        nil
      end

      def pnpm_version_major(lockfile_version = nil)
        parse_major(pnpm_engine_exact_version) || package_manager_major || parse_major(lockfile_version)
      end

      def node_version_major
        engines = package_json_engines
        return nil unless engines.is_a?(Hash)

        parse_major(engines["node"])
      end

      def script_policy
        if scripts_configured?
          "allowed"
        else
          "none"
        end
      end

      def enforce_manager_compatible_with(lockfile_version, allow_patch_drift: false)
        patch_drift_override_used = false

        # When packageManager provides an exact version (e.g. "pnpm@10.17.0"),
        # a range in engines.pnpm (e.g. "^10") is acceptable — it's just a
        # compatibility constraint, not the version source of truth.
        if pnpm_engine && pnpm_engine_exact_version.nil? && package_manager_version.nil?
          raise ArgumentError,
                "engines.pnpm must pin an exact version (for example 9.6.0); got #{pnpm_engine.inspect}"
        end

        if pnpm_engine_exact_version && package_manager_version && pnpm_engine_exact_version != package_manager_version
          if allow_patch_drift
            engine_major = parse_major(pnpm_engine_exact_version)
            manager_major = parse_major(package_manager_version)
            if !engine_major.nil? && engine_major == manager_major
              patch_drift_override_used = true
            else
              raise ArgumentError,
                    "engines.pnpm #{pnpm_engine_exact_version} must match packageManager pnpm@#{package_manager_version}"
            end
          else
            raise ArgumentError,
                  "engines.pnpm #{pnpm_engine_exact_version} must match packageManager pnpm@#{package_manager_version}"
          end
        end

        pnpm_major = pnpm_version_major(lockfile_version)
        unless pnpm_major.nil?
          lockfile_major = parse_major(lockfile_version)
          if !lockfile_major.nil? && pnpm_major < lockfile_major
            raise ArgumentError,
                  "pnpm major #{pnpm_major} is older than pnpm lockfileVersion #{lockfile_version} " \
                  "(requires major >= #{lockfile_major})"
          end
        end

        patch_drift_override_used
      end

      private

      def detect_package_manager
        package_json_data["packageManager"]
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

      def parse_package_manager_version(value)
        return nil if value.nil?
        raw = value.to_s.strip
        match = raw.match(/\Apnpm@v?(\d+\.\d+\.\d+(?:-[0-9A-Za-z\-.]+)?)(?:\+.*)?\z/i)
        return nil unless match

        match[1]
      end

      def exact_version?(value)
        value.to_s.match?(/\A\d+\.\d+\.\d+(?:-[0-9A-Za-z\-.]+)?\z/)
      end

      def parse_major(value)
        match = value.to_s.match(/(\d+)/)
        match ? match[1].to_i : nil
      end

      def package_json_engines
        data = package_json_data
        engines = data["engines"]
        engines.is_a?(Hash) ? engines : nil
      rescue StandardError
        nil
      end

      def package_json_data
        return @package_json_data if defined?(@package_json_data)

        package_json = File.join(@root, "package.json")
        @package_json_data =
          if File.exist?(package_json)
            JSON.parse(File.read(package_json))
          else
            {}
          end
      rescue JSON::ParserError
        @package_json_data = {}
      rescue StandardError
        @package_json_data = {}
      end
    end
  end
end
