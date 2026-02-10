#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jbuilder 2.14.0
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
  pname = "jbuilder";
  version = "2.14.0";
  src = builtins.path {
    path = ./source;
    name = "jbuilder-2.14.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jbuilder-2.14.0
        cp -r . $dest/gems/jbuilder-2.14.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jbuilder-2.14.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jbuilder"
      s.version = "2.14.0"
      s.summary = "jbuilder"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
