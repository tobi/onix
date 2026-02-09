#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper 5.8.2
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
  pname = "doorkeeper";
  version = "5.8.2";
  src = builtins.path {
    path = ./source;
    name = "doorkeeper-5.8.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/doorkeeper-5.8.2
        cp -r . $dest/gems/doorkeeper-5.8.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/doorkeeper-5.8.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "doorkeeper"
      s.version = "5.8.2"
      s.summary = "doorkeeper"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
