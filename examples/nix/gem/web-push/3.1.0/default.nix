#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# web-push 3.1.0
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
  pname = "web-push";
  version = "3.1.0";
  src = builtins.path {
    path = ./source;
    name = "web-push-3.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/web-push-3.1.0
        cp -r . $dest/gems/web-push-3.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/web-push-3.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "web-push"
      s.version = "3.1.0"
      s.summary = "web-push"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
