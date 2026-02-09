#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-pop 0.1.0
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
  pname = "net-pop";
  version = "0.1.0";
  src = builtins.path {
    path = ./source;
    name = "net-pop-0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-pop-0.1.0
        cp -r . $dest/gems/net-pop-0.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-pop-0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-pop"
      s.version = "0.1.0"
      s.summary = "net-pop"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
