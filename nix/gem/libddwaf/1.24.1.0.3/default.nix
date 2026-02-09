#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libddwaf 1.24.1.0.3
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
  pname = "libddwaf";
  version = "1.24.1.0.3";
  src = builtins.path {
    path = ./source;
    name = "libddwaf-1.24.1.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/libddwaf-1.24.1.0.3
        cp -r . $dest/gems/libddwaf-1.24.1.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/libddwaf-1.24.1.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "libddwaf"
      s.version = "1.24.1.0.3"
      s.summary = "libddwaf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
