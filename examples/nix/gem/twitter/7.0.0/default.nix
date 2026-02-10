#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twitter 7.0.0
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
  pname = "twitter";
  version = "7.0.0";
  src = builtins.path {
    path = ./source;
    name = "twitter-7.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/twitter-7.0.0
        cp -r . $dest/gems/twitter-7.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/twitter-7.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "twitter"
      s.version = "7.0.0"
      s.summary = "twitter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
