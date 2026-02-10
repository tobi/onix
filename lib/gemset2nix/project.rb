# frozen_string_literal: true

require "tmpdir"

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
    def gemsets_dir     = File.join(root, "gemsets")

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

    # Load all gem metadata from cache
    def load_metadata
      meta = {}
      Dir.glob(File.join(meta_dir, "*.json")).each do |f|
        m = JSON.parse(File.read(f), symbolize_names: true)
        meta["#{m[:name]}-#{m[:version]}"] = m
      end
      meta
    end

    # Check if project is initialized
    def initialized?
      Dir.exist?(cache_dir) && Dir.exist?(File.join(root, "nix"))
    end

    # Parse a Gemfile.lock / .gemset file safely.
    # Bundler's LockfileParser crashes without a Gemfile in cwd (PATH/GIT sources
    # call Bundler.root). We set BUNDLE_GEMFILE to a dummy file to avoid that.
    def parse_lockfile(path)
      @_dummy_gemfile ||= begin
        f = File.join(Dir.tmpdir, "Gemfile-gemset2nix-#{$$}")
        File.write(f, "source 'https://rubygems.org'\n")
        at_exit { File.delete(f) rescue nil }
        f
      end
      old = ENV["BUNDLE_GEMFILE"]
      ENV["BUNDLE_GEMFILE"] = @_dummy_gemfile
      Bundler::LockfileParser.new(File.read(path))
    ensure
      old ? ENV["BUNDLE_GEMFILE"] = old : ENV.delete("BUNDLE_GEMFILE")
    end
  end
end
