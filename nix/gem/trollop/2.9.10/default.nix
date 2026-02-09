#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# trollop 2.9.10
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
  pname = "trollop";
  version = "2.9.10";
  src = builtins.path {
    path = ./source;
    name = "trollop-2.9.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/trollop-2.9.10
        cp -r . $dest/gems/trollop-2.9.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/trollop-2.9.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "trollop"
      s.version = "2.9.10"
      s.summary = "trollop"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
