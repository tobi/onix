#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stringex 2.8.6
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
  pname = "stringex";
  version = "2.8.6";
  src = builtins.path {
    path = ./source;
    name = "stringex-2.8.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stringex-2.8.6
        cp -r . $dest/gems/stringex-2.8.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/stringex-2.8.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stringex"
      s.version = "2.8.6"
      s.summary = "stringex"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
