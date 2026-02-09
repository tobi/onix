#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-2 0.11.0
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
  pname = "http-2";
  version = "0.11.0";
  src = builtins.path {
    path = ./source;
    name = "http-2-0.11.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/http-2-0.11.0
        cp -r . $dest/gems/http-2-0.11.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/http-2-0.11.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "http-2"
      s.version = "0.11.0"
      s.summary = "http-2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
