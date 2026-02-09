#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mail 2.8.1
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
  pname = "mail";
  version = "2.8.1";
  src = builtins.path {
    path = ./source;
    name = "mail-2.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/mail-2.8.1
        cp -r . $dest/gems/mail-2.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mail-2.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mail"
      s.version = "2.8.1"
      s.summary = "mail"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
