#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validates_zipcode 0.5.4
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
  pname = "validates_zipcode";
  version = "0.5.4";
  src = builtins.path {
    path = ./source;
    name = "validates_zipcode-0.5.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/validates_zipcode-0.5.4
        cp -r . $dest/gems/validates_zipcode-0.5.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/validates_zipcode-0.5.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "validates_zipcode"
      s.version = "0.5.4"
      s.summary = "validates_zipcode"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
