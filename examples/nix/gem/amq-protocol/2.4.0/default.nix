#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# amq-protocol 2.4.0
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
  pname = "amq-protocol";
  version = "2.4.0";
  src = builtins.path {
    path = ./source;
    name = "amq-protocol-2.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/amq-protocol-2.4.0
        cp -r . $dest/gems/amq-protocol-2.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/amq-protocol-2.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "amq-protocol"
      s.version = "2.4.0"
      s.summary = "amq-protocol"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
