#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-mashify 1.0.0
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
  pname = "faraday-mashify";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "faraday-mashify-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-mashify-1.0.0
        cp -r . $dest/gems/faraday-mashify-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-mashify-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-mashify"
      s.version = "1.0.0"
      s.summary = "faraday-mashify"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
