#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-spinner 0.9.2
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
  pname = "tty-spinner";
  version = "0.9.2";
  src = builtins.path {
    path = ./source;
    name = "tty-spinner-0.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tty-spinner-0.9.2
        cp -r . $dest/gems/tty-spinner-0.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-spinner-0.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-spinner"
      s.version = "0.9.2"
      s.summary = "tty-spinner"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
