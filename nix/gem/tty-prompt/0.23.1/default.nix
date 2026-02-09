#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-prompt 0.23.1
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "tty-prompt";
  version = "0.23.1";
  src = builtins.path {
    path = ./source;
    name = "tty-prompt-0.23.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/tty-prompt-0.23.1
        cp -r . $dest/gems/tty-prompt-0.23.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-prompt-0.23.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-prompt"
      s.version = "0.23.1"
      s.summary = "tty-prompt"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
