#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sshkit 1.25.0
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
  pname = "sshkit";
  version = "1.25.0";
  src = builtins.path {
    path = ./source;
    name = "sshkit-1.25.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sshkit-1.25.0
        cp -r . $dest/gems/sshkit-1.25.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sshkit-1.25.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sshkit"
      s.version = "1.25.0"
      s.summary = "sshkit"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
