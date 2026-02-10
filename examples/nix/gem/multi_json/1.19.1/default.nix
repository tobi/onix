#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multi_json 1.19.1
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
  pname = "multi_json";
  version = "1.19.1";
  src = builtins.path {
    path = ./source;
    name = "multi_json-1.19.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/multi_json-1.19.1
        cp -r . $dest/gems/multi_json-1.19.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/multi_json-1.19.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "multi_json"
      s.version = "1.19.1"
      s.summary = "multi_json"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
