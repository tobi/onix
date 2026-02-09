#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# table_print 1.5.5
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
  pname = "table_print";
  version = "1.5.5";
  src = builtins.path {
    path = ./source;
    name = "table_print-1.5.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/table_print-1.5.5
        cp -r . $dest/gems/table_print-1.5.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/table_print-1.5.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "table_print"
      s.version = "1.5.5"
      s.summary = "table_print"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
