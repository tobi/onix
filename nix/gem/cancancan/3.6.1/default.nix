#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cancancan 3.6.1
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
  pname = "cancancan";
  version = "3.6.1";
  src = builtins.path {
    path = ./source;
    name = "cancancan-3.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cancancan-3.6.1
        cp -r . $dest/gems/cancancan-3.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cancancan-3.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cancancan"
      s.version = "3.6.1"
      s.summary = "cancancan"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
