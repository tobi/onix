#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# alba 3.10.0
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
  pname = "alba";
  version = "3.10.0";
  src = builtins.path {
    path = ./source;
    name = "alba-3.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/alba-3.10.0
        cp -r . $dest/gems/alba-3.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/alba-3.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "alba"
      s.version = "3.10.0"
      s.summary = "alba"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
