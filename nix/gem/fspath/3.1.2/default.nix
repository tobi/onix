#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fspath 3.1.2
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
  pname = "fspath";
  version = "3.1.2";
  src = builtins.path {
    path = ./source;
    name = "fspath-3.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fspath-3.1.2
        cp -r . $dest/gems/fspath-3.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fspath-3.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fspath"
      s.version = "3.1.2"
      s.summary = "fspath"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
