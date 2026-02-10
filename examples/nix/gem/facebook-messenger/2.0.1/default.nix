#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# facebook-messenger 2.0.1
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
  pname = "facebook-messenger";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "facebook-messenger-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/facebook-messenger-2.0.1
        cp -r . $dest/gems/facebook-messenger-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/facebook-messenger-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "facebook-messenger"
      s.version = "2.0.1"
      s.summary = "facebook-messenger"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
