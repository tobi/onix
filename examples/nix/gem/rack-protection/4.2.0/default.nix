#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-protection 4.2.0
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
  pname = "rack-protection";
  version = "4.2.0";
  src = builtins.path {
    path = ./source;
    name = "rack-protection-4.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-protection-4.2.0
        cp -r . $dest/gems/rack-protection-4.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-protection-4.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-protection"
      s.version = "4.2.0"
      s.summary = "rack-protection"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
