#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# regexp_parser 2.10.0
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
  pname = "regexp_parser";
  version = "2.10.0";
  src = builtins.path {
    path = ./source;
    name = "regexp_parser-2.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/regexp_parser-2.10.0
        cp -r . $dest/gems/regexp_parser-2.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/regexp_parser-2.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "regexp_parser"
      s.version = "2.10.0"
      s.summary = "regexp_parser"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
