#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeliness 0.5.1
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
  pname = "timeliness";
  version = "0.5.1";
  src = builtins.path {
    path = ./source;
    name = "timeliness-0.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/timeliness-0.5.1
        cp -r . $dest/gems/timeliness-0.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timeliness-0.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timeliness"
      s.version = "0.5.1"
      s.summary = "timeliness"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
