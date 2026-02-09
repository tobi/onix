#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-log 3.2.3
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
  pname = "mixlib-log";
  version = "3.2.3";
  src = builtins.path {
    path = ./source;
    name = "mixlib-log-3.2.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mixlib-log-3.2.3
        cp -r . $dest/gems/mixlib-log-3.2.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mixlib-log-3.2.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mixlib-log"
      s.version = "3.2.3"
      s.summary = "mixlib-log"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
