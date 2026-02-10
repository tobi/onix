#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hana 1.3.5
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
  pname = "hana";
  version = "1.3.5";
  src = builtins.path {
    path = ./source;
    name = "hana-1.3.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/hana-1.3.5
        cp -r . $dest/gems/hana-1.3.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/hana-1.3.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "hana"
      s.version = "1.3.5"
      s.summary = "hana"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
