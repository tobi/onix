#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brakeman 7.0.0
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
  pname = "brakeman";
  version = "7.0.0";
  src = builtins.path {
    path = ./source;
    name = "brakeman-7.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/brakeman-7.0.0
        cp -r . $dest/gems/brakeman-7.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/brakeman-7.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "brakeman"
      s.version = "7.0.0"
      s.summary = "brakeman"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["brakeman"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/brakeman <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("brakeman", "brakeman", "7.0.0")
    BINSTUB
        chmod +x $dest/bin/brakeman
  '';
}
