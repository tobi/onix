#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-ld-preloaded 3.3.2
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
  pname = "json-ld-preloaded";
  version = "3.3.2";
  src = builtins.path {
    path = ./source;
    name = "json-ld-preloaded-3.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/json-ld-preloaded-3.3.2
        cp -r . $dest/gems/json-ld-preloaded-3.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/json-ld-preloaded-3.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "json-ld-preloaded"
      s.version = "3.3.2"
      s.summary = "json-ld-preloaded"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
