#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bootstrap-sass 3.3.7
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
  pname = "bootstrap-sass";
  version = "3.3.7";
  src = builtins.path {
    path = ./source;
    name = "bootstrap-sass-3.3.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bootstrap-sass-3.3.7
        cp -r . $dest/gems/bootstrap-sass-3.3.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bootstrap-sass-3.3.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bootstrap-sass"
      s.version = "3.3.7"
      s.summary = "bootstrap-sass"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
