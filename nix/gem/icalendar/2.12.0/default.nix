#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# icalendar 2.12.0
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
  pname = "icalendar";
  version = "2.12.0";
  src = builtins.path {
    path = ./source;
    name = "icalendar-2.12.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/icalendar-2.12.0
        cp -r . $dest/gems/icalendar-2.12.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/icalendar-2.12.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "icalendar"
      s.version = "2.12.0"
      s.summary = "icalendar"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
