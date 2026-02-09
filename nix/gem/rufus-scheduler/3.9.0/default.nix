#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rufus-scheduler 3.9.0
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
  pname = "rufus-scheduler";
  version = "3.9.0";
  src = builtins.path {
    path = ./source;
    name = "rufus-scheduler-3.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rufus-scheduler-3.9.0
        cp -r . $dest/gems/rufus-scheduler-3.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rufus-scheduler-3.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rufus-scheduler"
      s.version = "3.9.0"
      s.summary = "rufus-scheduler"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
