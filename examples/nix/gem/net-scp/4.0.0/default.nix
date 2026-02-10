#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-scp 4.0.0
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
  pname = "net-scp";
  version = "4.0.0";
  src = builtins.path {
    path = ./source;
    name = "net-scp-4.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-scp-4.0.0
        cp -r . $dest/gems/net-scp-4.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-scp-4.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-scp"
      s.version = "4.0.0"
      s.summary = "net-scp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
