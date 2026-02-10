#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-inotify 0.11.0
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
  pname = "rb-inotify";
  version = "0.11.0";
  src = builtins.path {
    path = ./source;
    name = "rb-inotify-0.11.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rb-inotify-0.11.0
        cp -r . $dest/gems/rb-inotify-0.11.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rb-inotify-0.11.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rb-inotify"
      s.version = "0.11.0"
      s.summary = "rb-inotify"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
