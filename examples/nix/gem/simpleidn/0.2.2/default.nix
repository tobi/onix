#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simpleidn 0.2.2
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
  pname = "simpleidn";
  version = "0.2.2";
  src = builtins.path {
    path = ./source;
    name = "simpleidn-0.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simpleidn-0.2.2
        cp -r . $dest/gems/simpleidn-0.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simpleidn-0.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simpleidn"
      s.version = "0.2.2"
      s.summary = "simpleidn"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
