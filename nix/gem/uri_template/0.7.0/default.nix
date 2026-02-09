#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uri_template 0.7.0
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
  pname = "uri_template";
  version = "0.7.0";
  src = builtins.path {
    path = ./source;
    name = "uri_template-0.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/uri_template-0.7.0
        cp -r . $dest/gems/uri_template-0.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uri_template-0.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uri_template"
      s.version = "0.7.0"
      s.summary = "uri_template"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
