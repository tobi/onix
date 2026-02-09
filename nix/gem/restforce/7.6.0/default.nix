#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# restforce 7.6.0
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
  version = "7.6.0";
  src = builtins.path {
    path = ./source;
    name = "restforce-7.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/restforce-7.6.0
        cp -r . $dest/gems/restforce-7.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/restforce-7.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "restforce"
      s.version = "7.6.0"
      s.summary = "restforce"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
