# frozen_string_literal: true

module Onix
  module Pnpm
    module NodeInference
      # Deterministic package-name -> build metadata map used by generate.
      #
      # This is intentionally small and explicit for phase-1. Invariants:
      # - mapping keys are canonical package names from lockfile entries
      # - returned config is minimal and purely additive
      # - manual overlays can always replace/extend via `overlays/node/*.nix`
      RULES = {
        "grpc" => {
          deps: %w[python3 pkg-config],
          pre_install: "export ONIX_NODE_INFERRED_GRPC_BUILD=1",
        },
        "node-sass" => {
          deps: %w[python3],
        },
        "@parcel/watcher" => {
          deps: %w[python3],
          pre_install: "export ONIX_NODE_INFERRED_PARCEL_WATCHER=1",
        },
      }.freeze

      def self.config_for(name_or_entry)
        name = (name_or_entry.respond_to?(:name) ? name_or_entry.name : name_or_entry).to_s
        raw = RULES[name]
        return nil unless raw

        normalize(raw)
      end

      def self.normalize(raw)
        {
          deps: normalize_array(raw[:deps]),
          pre_install: normalize_string(raw[:pre_install]),
          pre_pnpm_install: normalize_string(raw[:pre_pnpm_install]),
          pnpm_install_flags: normalize_array(raw[:pnpm_install_flags]),
        }.delete_if do |_key, value|
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

      def self.normalize_array(values)
        return nil unless values

        values = Array(values).map(&:to_s).reject(&:empty?)
        return nil if values.empty?

        values.sort.uniq
      end

      def self.normalize_string(value)
        value = value.to_s.strip
        return nil if value.empty?
        value
      end
    end
  end
end
