#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slop 4.10.1
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
  pname = "slop";
  version = "4.10.1";
  src = builtins.path {
    path = ./source;
    name = "slop-4.10.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/slop-4.10.1
        cp -r . $dest/gems/slop-4.10.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/slop-4.10.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "slop"
      s.version = "4.10.1"
      s.summary = "slop"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
