#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ast 2.4.3
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
  pname = "ast";
  version = "2.4.3";
  src = builtins.path {
    path = ./source;
    name = "ast-2.4.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/ast-2.4.3
        cp -r . $dest/gems/ast-2.4.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ast-2.4.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ast"
      s.version = "2.4.3"
      s.summary = "ast"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
