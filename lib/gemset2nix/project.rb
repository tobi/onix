# frozen_string_literal: true

require "scint"
require "scint/lockfile/parser"
require "scint/materializer"

module Gemset2Nix
  # Represents a gemset2nix project directory — knows all the paths.
  class Project
    attr_reader :root

    def initialize(root = Dir.pwd)
      @root = File.expand_path(root)
    end

    def cache_dir      = File.join(root, "cache")
    def source_dir     = File.join(cache_dir, "sources")
    def meta_dir       = File.join(cache_dir, "meta")
    def gem_cache_dir  = File.join(cache_dir, "gems")
    def git_clones_dir = File.join(cache_dir, "git-clones")
    def overlays_dir   = File.join(root, "overlays")
    def output_dir     = File.join(root, "nix", "gem")
    def app_dir        = File.join(root, "nix", "app")
    def modules_dir    = File.join(root, "nix", "modules")
    def gemsets_dir    = File.join(root, "gemsets")

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

    # Parse a Gemfile.lock / .gemset file via Scint's lockfile parser.
    # Returns a Scint::Lockfile::LockfileData with .specs, .sources, etc.
    def parse_lockfile(path)
      Scint::Lockfile::Parser.parse(path)
    end

    # Get a Materializer for this project's cache directory.
    def materializer
      @materializer ||= Scint::Materializer.new(cache_dir: cache_dir)
    end

    # Load all gem metadata from cache
    def load_metadata
      materializer.all_metadata
    end

    # Check if project is initialized
    def initialized?
      Dir.exist?(cache_dir) && Dir.exist?(File.join(root, "nix"))
    end
  end
end
