#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# carrierwave 2.2.6
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
  pname = "carrierwave";
  version = "2.2.6";
  src = builtins.path {
    path = ./source;
    name = "carrierwave-2.2.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/carrierwave-2.2.6
        cp -r . $dest/gems/carrierwave-2.2.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/carrierwave-2.2.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "carrierwave"
      s.version = "2.2.6"
      s.summary = "carrierwave"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
