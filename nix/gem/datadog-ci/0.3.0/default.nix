#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# datadog-ci 0.3.0
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
  pname = "datadog-ci";
  version = "0.3.0";
  src = builtins.path {
    path = ./source;
    name = "datadog-ci-0.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/datadog-ci-0.3.0
        cp -r . $dest/gems/datadog-ci-0.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/datadog-ci-0.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "datadog-ci"
      s.version = "0.3.0"
      s.summary = "datadog-ci"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
