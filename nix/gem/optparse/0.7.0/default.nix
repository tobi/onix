#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# optparse 0.7.0
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
  pname = "optparse";
  version = "0.7.0";
  src = builtins.path {
    path = ./source;
    name = "optparse-0.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/optparse-0.7.0
        cp -r . $dest/gems/optparse-0.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/optparse-0.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "optparse"
      s.version = "0.7.0"
      s.summary = "optparse"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
