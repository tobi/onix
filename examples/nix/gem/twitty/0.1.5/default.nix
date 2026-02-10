#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twitty 0.1.5
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
  pname = "twitty";
  version = "0.1.5";
  src = builtins.path {
    path = ./source;
    name = "twitty-0.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/twitty-0.1.5
        cp -r . $dest/gems/twitty-0.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/twitty-0.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "twitty"
      s.version = "0.1.5"
      s.summary = "twitty"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
