#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lint_roller 1.0.0
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
  pname = "lint_roller";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "lint_roller-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/lint_roller-1.0.0
        cp -r . $dest/gems/lint_roller-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lint_roller-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lint_roller"
      s.version = "1.0.0"
      s.summary = "lint_roller"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
