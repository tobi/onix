#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-protocol 0.2.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "net-protocol";
  version = "0.2.2";
  src = builtins.path {
    path = ./source;
    name = "net-protocol-0.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/net-protocol-0.2.2
        cp -r . $dest/gems/net-protocol-0.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-protocol-0.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-protocol"
      s.version = "0.2.2"
      s.summary = "net-protocol"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
