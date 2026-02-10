#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bugsnag 6.28.0
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
  pname = "bugsnag";
  version = "6.28.0";
  src = builtins.path {
    path = ./source;
    name = "bugsnag-6.28.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bugsnag-6.28.0
        cp -r . $dest/gems/bugsnag-6.28.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bugsnag-6.28.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bugsnag"
      s.version = "6.28.0"
      s.summary = "bugsnag"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
