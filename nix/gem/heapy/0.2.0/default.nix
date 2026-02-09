#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# heapy 0.2.0
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
  pname = "heapy";
  version = "0.2.0";
  src = builtins.path {
    path = ./source;
    name = "heapy-0.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/heapy-0.2.0
        cp -r . $dest/gems/heapy-0.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/heapy-0.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "heapy"
      s.version = "0.2.0"
      s.summary = "heapy"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["heapy"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/heapy <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("heapy", "heapy", "0.2.0")
    BINSTUB
        chmod +x $dest/bin/heapy
  '';
}
