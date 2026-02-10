#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring-watcher-listen 2.0.1
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
  pname = "spring-watcher-listen";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "spring-watcher-listen-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/spring-watcher-listen-2.0.1
        cp -r . $dest/gems/spring-watcher-listen-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spring-watcher-listen-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spring-watcher-listen"
      s.version = "2.0.1"
      s.summary = "spring-watcher-listen"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
