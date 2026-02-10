#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# diffy 3.4.3
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
  pname = "diffy";
  version = "3.4.3";
  src = builtins.path {
    path = ./source;
    name = "diffy-3.4.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/diffy-3.4.3
        cp -r . $dest/gems/diffy-3.4.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/diffy-3.4.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "diffy"
      s.version = "3.4.3"
      s.summary = "diffy"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
