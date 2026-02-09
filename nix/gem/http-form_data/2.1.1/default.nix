#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-form_data 2.1.1
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
  pname = "http-form_data";
  version = "2.1.1";
  src = builtins.path {
    path = ./source;
    name = "http-form_data-2.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/http-form_data-2.1.1
        cp -r . $dest/gems/http-form_data-2.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/http-form_data-2.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "http-form_data"
      s.version = "2.1.1"
      s.summary = "http-form_data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
