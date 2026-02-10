#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov 0.21.2
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
  pname = "simplecov";
  version = "0.21.2";
  src = builtins.path {
    path = ./source;
    name = "simplecov-0.21.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simplecov-0.21.2
        cp -r . $dest/gems/simplecov-0.21.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simplecov-0.21.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simplecov"
      s.version = "0.21.2"
      s.summary = "simplecov"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
