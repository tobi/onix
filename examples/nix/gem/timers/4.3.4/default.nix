#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timers 4.3.4
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
  pname = "timers";
  version = "4.3.4";
  src = builtins.path {
    path = ./source;
    name = "timers-4.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/timers-4.3.4
        cp -r . $dest/gems/timers-4.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timers-4.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timers"
      s.version = "4.3.4"
      s.summary = "timers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
