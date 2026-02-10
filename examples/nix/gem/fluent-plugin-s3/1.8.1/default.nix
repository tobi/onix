#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-s3 1.8.1
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
  pname = "fluent-plugin-s3";
  version = "1.8.1";
  src = builtins.path {
    path = ./source;
    name = "fluent-plugin-s3-1.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluent-plugin-s3-1.8.1
        cp -r . $dest/gems/fluent-plugin-s3-1.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluent-plugin-s3-1.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluent-plugin-s3"
      s.version = "1.8.1"
      s.summary = "fluent-plugin-s3"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
