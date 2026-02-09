#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-form_data 2.3.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "http-form_data";
  version = "2.3.0";
  src = builtins.path {
    path = ./source;
    name = "http-form_data-2.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/http-form_data-2.3.0
        cp -r . $dest/gems/http-form_data-2.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/http-form_data-2.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "http-form_data"
      s.version = "2.3.0"
      s.summary = "http-form_data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
