#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gli 2.22.2
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
  pname = "gli";
  version = "2.22.2";
  src = builtins.path {
    path = ./source;
    name = "gli-2.22.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gli-2.22.2
        cp -r . $dest/gems/gli-2.22.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gli-2.22.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gli"
      s.version = "2.22.2"
      s.summary = "gli"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["gli"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/gli <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gli", "gli", "2.22.2")
    BINSTUB
        chmod +x $dest/bin/gli
  '';
}
