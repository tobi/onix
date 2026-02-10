#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activejob 8.0.3
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
  pname = "activejob";
  version = "8.0.3";
  src = builtins.path {
    path = ./source;
    name = "activejob-8.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/activejob-8.0.3
        cp -r . $dest/gems/activejob-8.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activejob-8.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activejob"
      s.version = "8.0.3"
      s.summary = "activejob"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
