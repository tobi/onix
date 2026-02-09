#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tracking_number 2.4.0
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
  pname = "tracking_number";
  version = "2.4.0";
  src = builtins.path {
    path = ./source;
    name = "tracking_number-2.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tracking_number-2.4.0
        cp -r . $dest/gems/tracking_number-2.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tracking_number-2.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tracking_number"
      s.version = "2.4.0"
      s.summary = "tracking_number"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
