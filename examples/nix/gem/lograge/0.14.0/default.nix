#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lograge 0.14.0
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
  pname = "lograge";
  version = "0.14.0";
  src = builtins.path {
    path = ./source;
    name = "lograge-0.14.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/lograge-0.14.0
        cp -r . $dest/gems/lograge-0.14.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lograge-0.14.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lograge"
      s.version = "0.14.0"
      s.summary = "lograge"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
