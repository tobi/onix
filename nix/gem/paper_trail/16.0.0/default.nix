#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# paper_trail 16.0.0
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
  pname = "paper_trail";
  version = "16.0.0";
  src = builtins.path {
    path = ./source;
    name = "paper_trail-16.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/paper_trail-16.0.0
        cp -r . $dest/gems/paper_trail-16.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/paper_trail-16.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "paper_trail"
      s.version = "16.0.0"
      s.summary = "paper_trail"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
