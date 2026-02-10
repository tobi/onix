#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# regexp_parser 2.11.1
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
  pname = "regexp_parser";
  version = "2.11.1";
  src = builtins.path {
    path = ./source;
    name = "regexp_parser-2.11.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/regexp_parser-2.11.1
        cp -r . $dest/gems/regexp_parser-2.11.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/regexp_parser-2.11.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "regexp_parser"
      s.version = "2.11.1"
      s.summary = "regexp_parser"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
