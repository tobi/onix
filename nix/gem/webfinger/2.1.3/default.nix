#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webfinger 2.1.3
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
  pname = "webfinger";
  version = "2.1.3";
  src = builtins.path {
    path = ./source;
    name = "webfinger-2.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webfinger-2.1.3
        cp -r . $dest/gems/webfinger-2.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webfinger-2.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webfinger"
      s.version = "2.1.3"
      s.summary = "webfinger"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
