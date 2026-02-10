#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uglifier 4.1.20
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
  pname = "uglifier";
  version = "4.1.20";
  src = builtins.path {
    path = ./source;
    name = "uglifier-4.1.20-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/uglifier-4.1.20
        cp -r . $dest/gems/uglifier-4.1.20/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uglifier-4.1.20.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uglifier"
      s.version = "4.1.20"
      s.summary = "uglifier"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
