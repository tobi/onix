#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov 0.21.1
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
  pname = "simplecov";
  version = "0.21.1";
  src = builtins.path {
    path = ./source;
    name = "simplecov-0.21.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simplecov-0.21.1
        cp -r . $dest/gems/simplecov-0.21.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simplecov-0.21.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simplecov"
      s.version = "0.21.1"
      s.summary = "simplecov"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
