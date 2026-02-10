# frozen_string_literal: true

module Gemset2Nix
  # Scans ext/**/extconf.rb to extract build requirements.
  # Returns raw findings — the nix generator decides how to map them.
  module ExtconfScanner
    Result = Struct.new(
      :pkg_configs,       # Array<String> — pkg_config('name') calls
      :libraries,         # Array<String> — have_library('name') calls
      :headers,           # Array<String> — find_header('name') calls
      :dir_configs,       # Array<String> — dir_config('name') calls
      :c_includes,        # Array<String> — #include <prefix/...> from C sources
      :system_lib_flags,  # String|nil — --enable-system-libraries etc.
      :build_gem_deps,    # Array<String> — require 'mini_portile2' etc.
      :build_tools,       # Array<String> — external tools needed (perl, make, etc.)
      :is_rust,           # bool — Cargo.toml with rb-sys
      keyword_init: true
    ) do
      def native?
        !pkg_configs.empty? || !libraries.empty? || !dir_configs.empty? || !c_includes.empty? || is_rust
      end

      def needs_auto_deps?
        native? || !build_tools.empty? || !build_gem_deps.empty?
      end
    end

    # Libs that are always available — not real deps
    IGNORE_LIBS = Set.new(%w[c m dl pthread rt nsl socket stdc++ gcc_s objc]).freeze

    # dir_config names that don't indicate external deps
    IGNORE_DIR_CONFIGS = Set.new(%w[opt]).freeze

    # Build-time gem requires → gem name
    BUILD_TIME_GEMS = {
      "mini_portile2" => "mini_portile2",
      "rb_sys/mkmf"   => "rb_sys",
      "rb_sys"         => "rb_sys",
      "pkg-config"     => "pkg-config",
      "mkmf-rice"      => "rice",
      "rice"           => "rice",
    }.freeze

    # C header include prefixes that indicate system library deps
    C_INCLUDE_PREFIXES = %w[
      openssl libxml libxslt yaml zlib sqlite3 mysql curl
      glib gobject gio cairo pango gdk-pixbuf vips ffi
    ].freeze

    def self.scan(source_dir)
      result = Result.new(
        pkg_configs: [], libraries: [], headers: [],
        dir_configs: [], c_includes: [],
        system_lib_flags: nil, build_gem_deps: [], build_tools: [],
        is_rust: false
      )

      extconfs = Dir.glob(File.join(source_dir, "ext", "**", "extconf.rb"))
      return result if extconfs.empty?

      # Rust extension?
      Dir.glob(File.join(source_dir, "ext", "**", "Cargo.toml")).each do |ct|
        content = (File.read(ct, encoding: "utf-8") rescue next)
        if content.include?("rb-sys") || content.include?("rb_sys")
          result.is_rust = true
          result.build_gem_deps << "rb_sys"
          break
        end
      end

      extconfs.each do |extconf|
        content = (File.read(extconf, encoding: "utf-8") rescue next)

        content.scan(/(?<!\w)pkg_config\s*\(\s*['"]([^'"]+)['"]\s*\)/) do |m|
          result.pkg_configs << m[0]
        end

        content.scan(/(?<!\w)have_library\s*\(\s*['"]([^'"]+)['"]/) do |m|
          name = m[0]
          # Skip Ruby interpolations (e.g. "lib#{lib}") and ignored libs
          next if name.include?('#')
          result.libraries << name unless IGNORE_LIBS.include?(name)
        end

        content.scan(/(?<!\w)find_header\s*\(\s*['"]([^'"]+)['"]/) do |m|
          next if m[0].include?('#')
          result.headers << m[0]
        end

        # dir_config hints at a library dependency
        content.scan(/(?<!\w)dir_config\s*\(\s*['"]([^'"]+)['"]/) do |m|
          name = m[0]
          next if name.include?('#')
          result.dir_configs << name unless IGNORE_DIR_CONFIGS.include?(name)
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

        # Detect build tools needed (perl, python, cmake, etc.)
        content.scan(/Open3\.capture\w*\s*\(\s*(['"]?)(\w+)\1/) do |_q, tool|
          result.build_tools << tool if %w[perl python python3 cmake].include?(tool)
        end
        # Also detect tools invoked via system() or backticks
        content.scan(/system\s*\(\s*['"](\w+)['"]/) do |m|
          result.build_tools << m[0] if %w[perl python python3 cmake].include?(m[0])
        end
      end

      # Scan C source files for #include directives to detect implicit deps
      c_sources = Dir.glob(File.join(source_dir, "ext", "**", "*.{c,h}"))
      c_sources.each do |csrc|
        content = (File.read(csrc, encoding: "utf-8") rescue next)
        content.scan(/#include\s+<(\w+)\//) do |m|
          prefix = m[0]
          result.c_includes << prefix if C_INCLUDE_PREFIXES.include?(prefix)
        end
      end

      # Detect build tools from Makefiles.
      # Scan ext/ and vendor/ since extconf.rb often invokes make on vendored code.
      # Also scan any directory referenced by path literals in extconf.
      makefile_dirs = Set.new
      makefile_dirs.merge(Dir.glob(File.join(source_dir, "{ext,vendor}", "**", "{Makefile,GNUmakefile}")).map { |f| File.dirname(f) })

      # Resolve path literals from extconf that reference other directories
      extconfs.each do |extconf|
        content = (File.read(extconf, encoding: "utf-8") rescue next)
        # Match File.expand_path("../../vendor/something", __dir__) and similar patterns
        content.scan(%r{['"](\.\.[\w/.-]+)['"]\s*,\s*__dir__}) do |m|
          resolved = File.expand_path(m[0], File.dirname(extconf)) rescue next
          makefile_dirs.merge(Dir.glob(File.join(resolved, "{Makefile,GNUmakefile}")).map { |f| File.dirname(f) }) if Dir.exist?(resolved)
        end
      end

      makefile_dirs.each do |dir|
        Dir.glob(File.join(dir, "{Makefile,GNUmakefile}")).each do |mf|
          mf_content = (File.read(mf, encoding: "utf-8") rescue next)
          result.build_tools << "perl" if mf_content.match?(/\bperl\b/)
          result.build_tools << "python3" if mf_content.match?(/\bpython[23]?\b/)
          result.build_tools << "cmake" if mf_content.match?(/\bcmake\b/)
        end
      end

      result.pkg_configs.uniq!
      result.libraries.uniq!
      result.headers.uniq!
      result.dir_configs.uniq!
      result.c_includes.uniq!
      result.build_gem_deps.uniq!
      result.build_tools.uniq!
      result
    end
  end
end
