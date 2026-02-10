#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ice_nine 0.11.2
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
  pname = "ice_nine";
  version = "0.11.2";
  src = builtins.path {
    path = ./source;
    name = "ice_nine-0.11.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ice_nine-0.11.2
        cp -r . $dest/gems/ice_nine-0.11.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ice_nine-0.11.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ice_nine"
      s.version = "0.11.2"
      s.summary = "ice_nine"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
