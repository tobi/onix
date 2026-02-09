#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gserver 0.0.1
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
  pname = "gserver";
  version = "0.0.1";
  src = builtins.path {
    path = ./source;
    name = "gserver-0.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gserver-0.0.1
        cp -r . $dest/gems/gserver-0.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gserver-0.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gserver"
      s.version = "0.0.1"
      s.summary = "gserver"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
