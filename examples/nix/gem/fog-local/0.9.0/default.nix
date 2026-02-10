#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-local 0.9.0
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
  pname = "fog-local";
  version = "0.9.0";
  src = builtins.path {
    path = ./source;
    name = "fog-local-0.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-local-0.9.0
        cp -r . $dest/gems/fog-local-0.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-local-0.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-local"
      s.version = "0.9.0"
      s.summary = "fog-local"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
