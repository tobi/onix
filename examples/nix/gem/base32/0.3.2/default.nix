#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# base32 0.3.2
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
  pname = "base32";
  version = "0.3.2";
  src = builtins.path {
    path = ./source;
    name = "base32-0.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/base32-0.3.2
        cp -r . $dest/gems/base32-0.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/base32-0.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "base32"
      s.version = "0.3.2"
      s.summary = "base32"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
