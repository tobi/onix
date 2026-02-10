#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# metainspector 5.15.0
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
  pname = "metainspector";
  version = "5.15.0";
  src = builtins.path {
    path = ./source;
    name = "metainspector-5.15.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/metainspector-5.15.0
        cp -r . $dest/gems/metainspector-5.15.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/metainspector-5.15.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "metainspector"
      s.version = "5.15.0"
      s.summary = "metainspector"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
