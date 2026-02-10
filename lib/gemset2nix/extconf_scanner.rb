# frozen_string_literal: true

module Gemset2Nix
  # Scans ext/**/extconf.rb to extract build requirements.
  # Returns raw findings — the nix generator decides how to map them.
  module ExtconfScanner
    Result = Struct.new(
      :pkg_configs,       # Array<String> — pkg_config('name') calls
      :libraries,         # Array<String> — have_library('name') calls
      :headers,           # Array<String> — find_header('name') calls
      :system_lib_flags,  # String|nil — --enable-system-libraries etc.
      :build_gem_deps,    # Array<String> — require 'mini_portile2' etc.
      :is_rust,           # bool — Cargo.toml with rb-sys
      keyword_init: true
    ) do
      def native?
        !pkg_configs.empty? || !libraries.empty? || is_rust
      end
    end

    # Libs that are always available — not real deps
    IGNORE_LIBS = Set.new(%w[c m dl pthread rt nsl socket stdc++ gcc_s objc]).freeze

    # Build-time gem requires → gem name
    BUILD_TIME_GEMS = {
      "mini_portile2" => "mini_portile2",
      "rb_sys/mkmf"   => "rb_sys",
      "rb_sys"         => "rb_sys",
      "pkg-config"     => "pkg-config",
      "mkmf-rice"      => "rice",
      "rice"           => "rice",
    }.freeze

    def self.scan(source_dir)
      result = Result.new(
        pkg_configs: [], libraries: [], headers: [],
        system_lib_flags: nil, build_gem_deps: [], is_rust: false
      )

      extconfs = Dir.glob(File.join(source_dir, "ext", "**", "extconf.rb"))
      return result if extconfs.empty?

      # Rust extension?
      Dir.glob(File.join(source_dir, "ext", "**", "Cargo.toml")).each do |ct|
        content = File.read(ct) rescue next
        if content.include?("rb-sys") || content.include?("rb_sys")
          result.is_rust = true
          result.build_gem_deps << "rb_sys"
          break
        end
      end

      extconfs.each do |extconf|
        content = File.read(extconf) rescue next

        content.scan(/pkg_config\s*\(\s*['"]([^'"]+)['"]\s*\)/) do |m|
          result.pkg_configs << m[0]
        end

        content.scan(/have_library\s*\(\s*['"]([^'"]+)['"]/) do |m|
          result.libraries << m[0] unless IGNORE_LIBS.include?(m[0])
        end

        content.scan(/find_header\s*\(\s*['"]([^'"]+)['"]/) do |m|
          result.headers << m[0]
        end

        if content.include?('enable_config("system-libraries"') ||
           content.include?("enable_config('system-libraries'")
          result.system_lib_flags = "--enable-system-libraries"
        end

        if content.include?("--use-system-libraries")
          result.system_lib_flags ||= "--use-system-libraries"
        end

        content.scan(/require\s+['"]([^'"]+)['"]/) do |m|
          gem = BUILD_TIME_GEMS[m[0]]
          result.build_gem_deps << gem if gem
        end
      end

      result.pkg_configs.uniq!
      result.libraries.uniq!
      result.headers.uniq!
      result.build_gem_deps.uniq!
      result
    end
  end
end
