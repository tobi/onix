#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validate_url 1.0.13
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
  pname = "validate_url";
  version = "1.0.13";
  src = builtins.path {
    path = ./source;
    name = "validate_url-1.0.13-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/validate_url-1.0.13
        cp -r . $dest/gems/validate_url-1.0.13/
        mkdir -p $dest/specifications
        cat > $dest/specifications/validate_url-1.0.13.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "validate_url"
      s.version = "1.0.13"
      s.summary = "validate_url"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
