#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timecop 0.9.9
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
  pname = "timecop";
  version = "0.9.9";
  src = builtins.path {
    path = ./source;
    name = "timecop-0.9.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/timecop-0.9.9
        cp -r . $dest/gems/timecop-0.9.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timecop-0.9.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timecop"
      s.version = "0.9.9"
      s.summary = "timecop"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
