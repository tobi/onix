#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# attr_encrypted 4.1.1
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
  pname = "attr_encrypted";
  version = "4.1.1";
  src = builtins.path {
    path = ./source;
    name = "attr_encrypted-4.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/attr_encrypted-4.1.1
        cp -r . $dest/gems/attr_encrypted-4.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/attr_encrypted-4.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "attr_encrypted"
      s.version = "4.1.1"
      s.summary = "attr_encrypted"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
