#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-supervision 0.20.6
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
  pname = "celluloid-supervision";
  version = "0.20.6";
  src = builtins.path {
    path = ./source;
    name = "celluloid-supervision-0.20.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-supervision-0.20.6
        cp -r . $dest/gems/celluloid-supervision-0.20.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-supervision-0.20.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-supervision"
      s.version = "0.20.6"
      s.summary = "celluloid-supervision"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
