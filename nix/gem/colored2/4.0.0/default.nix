#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colored2 4.0.0
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
  pname = "colored2";
  version = "4.0.0";
  src = builtins.path {
    path = ./source;
    name = "colored2-4.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/colored2-4.0.0
        cp -r . $dest/gems/colored2-4.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/colored2-4.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "colored2"
      s.version = "4.0.0"
      s.summary = "colored2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
