#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch 1.27.4
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
  pname = "algoliasearch";
  version = "1.27.4";
  src = builtins.path {
    path = ./source;
    name = "algoliasearch-1.27.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/algoliasearch-1.27.4
        cp -r . $dest/gems/algoliasearch-1.27.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/algoliasearch-1.27.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "algoliasearch"
      s.version = "1.27.4"
      s.summary = "algoliasearch"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
