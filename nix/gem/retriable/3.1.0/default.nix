#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# retriable 3.1.0
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
  pname = "retriable";
  version = "3.1.0";
  src = builtins.path {
    path = ./source;
    name = "retriable-3.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/retriable-3.1.0
        cp -r . $dest/gems/retriable-3.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/retriable-3.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "retriable"
      s.version = "3.1.0"
      s.summary = "retriable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
