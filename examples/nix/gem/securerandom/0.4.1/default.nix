#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# securerandom 0.4.1
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
  pname = "securerandom";
  version = "0.4.1";
  src = builtins.path {
    path = ./source;
    name = "securerandom-0.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/securerandom-0.4.1
        cp -r . $dest/gems/securerandom-0.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/securerandom-0.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "securerandom"
      s.version = "0.4.1"
      s.summary = "securerandom"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
