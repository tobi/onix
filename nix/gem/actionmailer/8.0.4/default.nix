#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailer 8.0.4
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
  pname = "actionmailer";
  version = "8.0.4";
  src = builtins.path {
    path = ./source;
    name = "actionmailer-8.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/actionmailer-8.0.4
        cp -r . $dest/gems/actionmailer-8.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionmailer-8.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionmailer"
      s.version = "8.0.4"
      s.summary = "actionmailer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
