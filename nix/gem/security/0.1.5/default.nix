#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# security 0.1.5
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
  pname = "security";
  version = "0.1.5";
  src = builtins.path {
    path = ./source;
    name = "security-0.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/security-0.1.5
        cp -r . $dest/gems/security-0.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/security-0.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "security"
      s.version = "0.1.5"
      s.summary = "security"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
