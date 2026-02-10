#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-protocol 0.2.1
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
  pname = "net-protocol";
  version = "0.2.1";
  src = builtins.path {
    path = ./source;
    name = "net-protocol-0.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-protocol-0.2.1
        cp -r . $dest/gems/net-protocol-0.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-protocol-0.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-protocol"
      s.version = "0.2.1"
      s.summary = "net-protocol"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
