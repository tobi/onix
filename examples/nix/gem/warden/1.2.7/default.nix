#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# warden 1.2.7
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
  pname = "warden";
  version = "1.2.7";
  src = builtins.path {
    path = ./source;
    name = "warden-1.2.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/warden-1.2.7
        cp -r . $dest/gems/warden-1.2.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/warden-1.2.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "warden"
      s.version = "1.2.7"
      s.summary = "warden"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
