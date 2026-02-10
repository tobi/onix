#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bindata 2.4.15
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
  pname = "bindata";
  version = "2.4.15";
  src = builtins.path {
    path = ./source;
    name = "bindata-2.4.15-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bindata-2.4.15
        cp -r . $dest/gems/bindata-2.4.15/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bindata-2.4.15.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bindata"
      s.version = "2.4.15"
      s.summary = "bindata"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
