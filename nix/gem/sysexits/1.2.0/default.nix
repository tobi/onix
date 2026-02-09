#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sysexits 1.2.0
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
  pname = "sysexits";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "sysexits-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sysexits-1.2.0
        cp -r . $dest/gems/sysexits-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sysexits-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sysexits"
      s.version = "1.2.0"
      s.summary = "sysexits"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
