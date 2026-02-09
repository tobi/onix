#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# require_all 1.5.0
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
  pname = "require_all";
  version = "1.5.0";
  src = builtins.path {
    path = ./source;
    name = "require_all-1.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/require_all-1.5.0
        cp -r . $dest/gems/require_all-1.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/require_all-1.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "require_all"
      s.version = "1.5.0"
      s.summary = "require_all"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
