#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mustermann 3.0.4
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
  pname = "mustermann";
  version = "3.0.4";
  src = builtins.path {
    path = ./source;
    name = "mustermann-3.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mustermann-3.0.4
        cp -r . $dest/gems/mustermann-3.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mustermann-3.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mustermann"
      s.version = "3.0.4"
      s.summary = "mustermann"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
