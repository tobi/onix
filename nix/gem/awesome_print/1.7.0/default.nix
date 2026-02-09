#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_print 1.7.0
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
  pname = "awesome_print";
  version = "1.7.0";
  src = builtins.path {
    path = ./source;
    name = "awesome_print-1.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/awesome_print-1.7.0
        cp -r . $dest/gems/awesome_print-1.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/awesome_print-1.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "awesome_print"
      s.version = "1.7.0"
      s.summary = "awesome_print"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
