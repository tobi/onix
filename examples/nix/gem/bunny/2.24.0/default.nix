#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bunny 2.24.0
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
  pname = "bunny";
  version = "2.24.0";
  src = builtins.path {
    path = ./source;
    name = "bunny-2.24.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bunny-2.24.0
        cp -r . $dest/gems/bunny-2.24.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bunny-2.24.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bunny"
      s.version = "2.24.0"
      s.summary = "bunny"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
