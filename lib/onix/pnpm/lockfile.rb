# frozen_string_literal: true

require "yaml"

module Onix
  module Pnpm
    class Lockfile
      Dependency = Struct.new(:name, :specifier, :version, :type, keyword_init: true)

      Package = Struct.new(
        :key,
        :resolution,
        :dependencies,
        :optional,
        :dev,
        :has_bin,
        :engines,
        :os,
        :cpu,
        :libc,
        keyword_init: true
      )
      Snapshot = Struct.new(:key, :dependencies, :optional, :dev, keyword_init: true)
      Importer = Struct.new(:name, :dependencies, :dev_dependencies, :optional_dependencies, keyword_init: true)

      attr_reader :lockfile_version, :importers, :packages, :snapshots, :settings

      def self.parse(path)
        data = YAML.load_file(path) || {}
        new(data)
      end

      def initialize(data)
        @settings = symbolize_keys(data["settings"] || data[:settings] || {})
        @lockfile_version = data["lockfileVersion"] || data[:lockfileVersion]
        @importers = parse_importers(data["importers"] || data[:importers])
        @packages = parse_packages(data["packages"] || data[:packages])
        @snapshots = parse_snapshots(data["snapshots"] || data[:snapshots])
      end

      def snapshot_for(name, dep_version)
        return nil if dep_version.nil?

        version = dep_version.to_s
        name = name.to_s

        canonical_snapshot_keys(name, version).each do |key|
          snapshot = snapshots[key]
          return snapshot if snapshot
        end

        nil
      end

      def canonical_snapshot_keys(name, version)
        parts = [version]
        bare = version.sub(/\(.+\z/, "")

        if bare != version
          parts << bare
        end

        if name && !name.empty?
          if version != name && !version.start_with?("#{name}@")
            parts << "#{name}@#{version}"
          end

          if bare != version && !bare.start_with?("#{name}@")
            parts << "#{name}@#{bare}"
          end
        end

        parts.uniq
      end

      def package_for(name, dep_version)
        return nil if dep_version.nil?

        canonical_snapshot_keys(name.to_s, dep_version.to_s).each do |key|
          package = packages[key]
          return package if package
        end

        nil
      end

      private

      def parse_importers(importers_data)
        (importers_data || {}).each_with_object({}) do |(name, importer_data), result|
          dependencies = parse_dependency_map(importer_data["dependencies"] || importer_data[:dependencies])
          dev_dependencies = parse_dependency_map(importer_data["devDependencies"] || importer_data[:devDependencies])
          optional_dependencies = parse_dependency_map(importer_data["optionalDependencies"] || importer_data[:optionalDependencies])
          result[name] = Importer.new(
            name: name,
            dependencies: dependencies,
            dev_dependencies: dev_dependencies,
            optional_dependencies: optional_dependencies,
          )
        end
      end

      def parse_packages(packages_data)
        (packages_data || {}).each_with_object({}) do |(key, data), result|
          next if key == "importer"

          parsed = Package.new(
            key: key,
            resolution: extract_resolution(data),
            dependencies: normalize_dependencies(data["dependencies"] || data[:dependencies]),
            optional: truthy?(data["optional"] || data[:optional]),
            dev: truthy?(data["dev"] || data[:dev]),
            has_bin: truthy?(data["hasBin"] || data[:hasBin]),
            engines: normalize_engines(data["engines"] || data[:engines]),
            os: normalize_array(data["os"] || data[:os]),
            cpu: normalize_array(data["cpu"] || data[:cpu]),
            libc: normalize_array(data["libc"] || data[:libc]),
          )
          result[key] = parsed
        end
      end

      def parse_snapshots(snapshots_data)
        (snapshots_data || {}).each_with_object({}) do |(key, data), result|
          result[key] = Snapshot.new(
            key: key,
            dependencies: normalize_dependencies(data["dependencies"] || data[:dependencies]),
            optional: truthy?(data["optional"] || data[:optional]),
            dev: truthy?(data["dev"] || data[:dev]),
          )
        end
      end

      def parse_dependency_map(raw)
        (raw || {}).each_with_object({}) do |(name, spec), out|
          out[name] = parse_dependency(name, spec, "runtime")
        end
      end

      def parse_dependency(name, value, type)
        if value.is_a?(Hash)
          version = value["version"] || value[:version]
          specifier = value["specifier"] || value[:specifier] || version
        else
          version = value.to_s
          specifier = version
        end

        Dependency.new(name: name, version: version, specifier: specifier, type: type)
      end

      def normalize_dependencies(raw)
        deps = {}
        (raw || {}).each do |name, version|
          deps[name] = normalize_version(version)
        end
        deps
      end

      def extract_resolution(data)
        return nil unless data.is_a?(Hash)
        resolution = data["resolution"] || data[:resolution]
        return nil unless resolution.is_a?(Hash) || resolution.is_a?(String)
        return resolution if resolution.is_a?(String)
        normalize_keys(resolution)
      end

      def normalize_engines(raw)
        normalize_keys(raw || {})
      end

      def normalize_version(version)
        version.to_s
      end

      def normalize_array(values)
        return [] if values.nil?

        Array(values).map(&:to_s)
      end

      def normalize_keys(hash)
        (hash || {}).each_with_object({}) do |(key, value), result|
          result[key.to_s] = value
        end
      end

      def symbolize_keys(hash)
        (hash || {}).each_with_object({}) do |(key, value), result|
          result[key.to_sym] = value
        end
      end

      def truthy?(value)
        value == true
      end
    end
  end
end
