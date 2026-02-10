#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicode_utils 1.2.2
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
  pname = "unicode_utils";
  version = "1.2.2";
  src = builtins.path {
    path = ./source;
    name = "unicode_utils-1.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/unicode_utils-1.2.2
        cp -r . $dest/gems/unicode_utils-1.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/unicode_utils-1.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "unicode_utils"
      s.version = "1.2.2"
      s.summary = "unicode_utils"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
