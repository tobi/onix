#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# table_print 1.5.7
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
  version = "1.5.7";
  src = builtins.path {
    path = ./source;
    name = "table_print-1.5.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/table_print-1.5.7
        cp -r . $dest/gems/table_print-1.5.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/table_print-1.5.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "table_print"
      s.version = "1.5.7"
      s.summary = "table_print"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
