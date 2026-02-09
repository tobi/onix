#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roadie 5.2.1
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
  pname = "roadie";
  version = "5.2.1";
  src = builtins.path {
    path = ./source;
    name = "roadie-5.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/roadie-5.2.1
        cp -r . $dest/gems/roadie-5.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/roadie-5.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "roadie"
      s.version = "5.2.1"
      s.summary = "roadie"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
