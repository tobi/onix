#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backports 3.25.3
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
  pname = "backports";
  version = "3.25.3";
  src = builtins.path {
    path = ./source;
    name = "backports-3.25.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/backports-3.25.3
        cp -r . $dest/gems/backports-3.25.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/backports-3.25.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "backports"
      s.version = "3.25.3"
      s.summary = "backports"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
