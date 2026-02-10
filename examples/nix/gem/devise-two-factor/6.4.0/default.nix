#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise-two-factor 6.4.0
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
  pname = "devise-two-factor";
  version = "6.4.0";
  src = builtins.path {
    path = ./source;
    name = "devise-two-factor-6.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/devise-two-factor-6.4.0
        cp -r . $dest/gems/devise-two-factor-6.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/devise-two-factor-6.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "devise-two-factor"
      s.version = "6.4.0"
      s.summary = "devise-two-factor"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
