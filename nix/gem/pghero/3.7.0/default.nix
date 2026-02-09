#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pghero 3.7.0
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
  pname = "pghero";
  version = "3.7.0";
  src = builtins.path {
    path = ./source;
    name = "pghero-3.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pghero-3.7.0
        cp -r . $dest/gems/pghero-3.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pghero-3.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pghero"
      s.version = "3.7.0"
      s.summary = "pghero"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
