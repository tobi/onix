#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuzzyurl 0.8.0
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
  pname = "fuzzyurl";
  version = "0.8.0";
  src = builtins.path {
    path = ./source;
    name = "fuzzyurl-0.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fuzzyurl-0.8.0
        cp -r . $dest/gems/fuzzyurl-0.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fuzzyurl-0.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fuzzyurl"
      s.version = "0.8.0"
      s.summary = "fuzzyurl"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
