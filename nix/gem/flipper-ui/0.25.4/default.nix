#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-ui 0.25.4
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
  pname = "flipper-ui";
  version = "0.25.4";
  src = builtins.path {
    path = ./source;
    name = "flipper-ui-0.25.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-ui-0.25.4
        cp -r . $dest/gems/flipper-ui-0.25.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-ui-0.25.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper-ui"
      s.version = "0.25.4"
      s.summary = "flipper-ui"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
