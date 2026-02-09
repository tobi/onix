#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-command 0.10.1
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
  pname = "tty-command";
  version = "0.10.1";
  src = builtins.path {
    path = ./source;
    name = "tty-command-0.10.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tty-command-0.10.1
        cp -r . $dest/gems/tty-command-0.10.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-command-0.10.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-command"
      s.version = "0.10.1"
      s.summary = "tty-command"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
