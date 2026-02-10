#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# restforce 8.0.0
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
  pname = "restforce";
  version = "8.0.0";
  src = builtins.path {
    path = ./source;
    name = "restforce-8.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/restforce-8.0.0
        cp -r . $dest/gems/restforce-8.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/restforce-8.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "restforce"
      s.version = "8.0.0"
      s.summary = "restforce"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
