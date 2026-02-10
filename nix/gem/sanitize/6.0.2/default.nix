#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sanitize 6.0.2
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
  pname = "sanitize";
  version = "6.0.2";
  src = builtins.path {
    path = ./source;
    name = "sanitize-6.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sanitize-6.0.2
        cp -r . $dest/gems/sanitize-6.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sanitize-6.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sanitize"
      s.version = "6.0.2"
      s.summary = "sanitize"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
