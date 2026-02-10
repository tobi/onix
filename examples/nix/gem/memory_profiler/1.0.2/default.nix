#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# memory_profiler 1.0.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "memory_profiler";
  version = "1.0.2";
  src = builtins.path {
    path = ./source;
    name = "memory_profiler-1.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/memory_profiler-1.0.2
        cp -r . $dest/gems/memory_profiler-1.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/memory_profiler-1.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "memory_profiler"
      s.version = "1.0.2"
      s.summary = "memory_profiler"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ruby-memory-profiler"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ruby-memory-profiler <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("memory_profiler", "ruby-memory-profiler", "1.0.2")
    BINSTUB
        chmod +x $dest/bin/ruby-memory-profiler
  '';
}
