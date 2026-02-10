#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# macaddr 1.7.1
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
  pname = "macaddr";
  version = "1.7.1";
  src = builtins.path {
    path = ./source;
    name = "macaddr-1.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/macaddr-1.7.1
        cp -r . $dest/gems/macaddr-1.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/macaddr-1.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "macaddr"
      s.version = "1.7.1"
      s.summary = "macaddr"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
