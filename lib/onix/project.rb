# frozen_string_literal: true

module Onix
  # Represents an onix project directory — knows all the paths.
  class Project
    attr_reader :root

    def initialize(root = Dir.pwd)
      @root = File.expand_path(root)
    end

    def nix_dir
      File.join(root, "nix")
    end

    def ruby_dir
      File.join(nix_dir, "ruby")
    end

    def node_dir
      File.join(nix_dir, "node")
    end

    def overlays_dir
      File.join(root, "overlays")
    end

    def packagesets_dir
      File.join(root, "packagesets")
    end

    # All overlay names (without .nix extension)
    def overlays
      @overlays ||= if Dir.exist?(overlays_dir)
        Dir.glob(File.join(overlays_dir, "*.nix")).map { |f| File.basename(f, ".nix") }
      else
        []
      end
    end

    def overlay?(name)
      overlays.include?(name)
    end

    # All packageset names (without .jsonl extension)
    def packageset_names
      Dir.glob(File.join(packagesets_dir, "*.jsonl")).map { |f| File.basename(f, ".jsonl") }.sort
    end

    # Check if project is initialized
    def initialized?
      Dir.exist?(nix_dir) && Dir.exist?(packagesets_dir)
    end
  end
end
