#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simctl 1.6.8
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
  pname = "simctl";
  version = "1.6.8";
  src = builtins.path {
    path = ./source;
    name = "simctl-1.6.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simctl-1.6.8
        cp -r . $dest/gems/simctl-1.6.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simctl-1.6.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simctl"
      s.version = "1.6.8"
      s.summary = "simctl"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
