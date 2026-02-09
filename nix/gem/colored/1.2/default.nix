#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colored 1.2
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
  pname = "colored";
  version = "1.2";
  src = builtins.path {
    path = ./source;
    name = "colored-1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/colored-1.2
        cp -r . $dest/gems/colored-1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/colored-1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "colored"
      s.version = "1.2"
      s.summary = "colored"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
