#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbpdf 1.21.4
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
  pname = "rbpdf";
  version = "1.21.4";
  src = builtins.path {
    path = ./source;
    name = "rbpdf-1.21.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rbpdf-1.21.4
        cp -r . $dest/gems/rbpdf-1.21.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rbpdf-1.21.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rbpdf"
      s.version = "1.21.4"
      s.summary = "rbpdf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
