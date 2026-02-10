#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colorize 1.0.5
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
  pname = "colorize";
  version = "1.0.5";
  src = builtins.path {
    path = ./source;
    name = "colorize-1.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/colorize-1.0.5
        cp -r . $dest/gems/colorize-1.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/colorize-1.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "colorize"
      s.version = "1.0.5"
      s.summary = "colorize"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
