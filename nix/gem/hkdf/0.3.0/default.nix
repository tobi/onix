#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hkdf 0.3.0
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
  pname = "hkdf";
  version = "0.3.0";
  src = builtins.path {
    path = ./source;
    name = "hkdf-0.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/hkdf-0.3.0
        cp -r . $dest/gems/hkdf-0.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/hkdf-0.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "hkdf"
      s.version = "0.3.0"
      s.summary = "hkdf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
