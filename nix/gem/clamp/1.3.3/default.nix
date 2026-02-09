#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# clamp 1.3.3
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
  pname = "clamp";
  version = "1.3.3";
  src = builtins.path {
    path = ./source;
    name = "clamp-1.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/clamp-1.3.3
        cp -r . $dest/gems/clamp-1.3.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/clamp-1.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "clamp"
      s.version = "1.3.3"
      s.summary = "clamp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
