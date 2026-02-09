#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wmi-lite 1.0.5
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
  pname = "wmi-lite";
  version = "1.0.5";
  src = builtins.path {
    path = ./source;
    name = "wmi-lite-1.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/wmi-lite-1.0.5
        cp -r . $dest/gems/wmi-lite-1.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wmi-lite-1.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wmi-lite"
      s.version = "1.0.5"
      s.summary = "wmi-lite"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
