#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rouge 4.6.0
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
  pname = "rouge";
  version = "4.6.0";
  src = builtins.path {
    path = ./source;
    name = "rouge-4.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rouge-4.6.0
        cp -r . $dest/gems/rouge-4.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rouge-4.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rouge"
      s.version = "4.6.0"
      s.summary = "rouge"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rougify"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rougify <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rouge", "rougify", "4.6.0")
    BINSTUB
        chmod +x $dest/bin/rougify
  '';
}
