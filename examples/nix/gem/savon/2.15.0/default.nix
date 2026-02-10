#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# savon 2.15.0
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
  pname = "savon";
  version = "2.15.0";
  src = builtins.path {
    path = ./source;
    name = "savon-2.15.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/savon-2.15.0
        cp -r . $dest/gems/savon-2.15.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/savon-2.15.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "savon"
      s.version = "2.15.0"
      s.summary = "savon"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
