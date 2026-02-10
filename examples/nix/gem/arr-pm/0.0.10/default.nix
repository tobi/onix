#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arr-pm 0.0.10
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
  pname = "arr-pm";
  version = "0.0.10";
  src = builtins.path {
    path = ./source;
    name = "arr-pm-0.0.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/arr-pm-0.0.10
        cp -r . $dest/gems/arr-pm-0.0.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/arr-pm-0.0.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "arr-pm"
      s.version = "0.0.10"
      s.summary = "arr-pm"
      s.require_paths = ["lib", "lib"]
      s.files = []
    end
    EOF
  '';
}
