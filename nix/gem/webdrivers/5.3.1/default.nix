#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webdrivers 5.3.1
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
  pname = "webdrivers";
  version = "5.3.1";
  src = builtins.path {
    path = ./source;
    name = "webdrivers-5.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webdrivers-5.3.1
        cp -r . $dest/gems/webdrivers-5.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webdrivers-5.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webdrivers"
      s.version = "5.3.1"
      s.summary = "webdrivers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
