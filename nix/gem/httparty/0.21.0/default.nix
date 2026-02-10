#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httparty 0.21.0
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
  pname = "httparty";
  version = "0.21.0";
  src = builtins.path {
    path = ./source;
    name = "httparty-0.21.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/httparty-0.21.0
        cp -r . $dest/gems/httparty-0.21.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/httparty-0.21.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "httparty"
      s.version = "0.21.0"
      s.summary = "httparty"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["httparty"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/httparty <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("httparty", "httparty", "0.21.0")
    BINSTUB
        chmod +x $dest/bin/httparty
  '';
}
