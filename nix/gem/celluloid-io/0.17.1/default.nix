#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-io 0.17.1
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
  pname = "celluloid-io";
  version = "0.17.1";
  src = builtins.path {
    path = ./source;
    name = "celluloid-io-0.17.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-io-0.17.1
        cp -r . $dest/gems/celluloid-io-0.17.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-io-0.17.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-io"
      s.version = "0.17.1"
      s.summary = "celluloid-io"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
