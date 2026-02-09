#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-emojis 1.0.44
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
  pname = "discourse-emojis";
  version = "1.0.44";
  src = builtins.path {
    path = ./source;
    name = "discourse-emojis-1.0.44-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/discourse-emojis-1.0.44
        cp -r . $dest/gems/discourse-emojis-1.0.44/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse-emojis-1.0.44.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse-emojis"
      s.version = "1.0.44"
      s.summary = "discourse-emojis"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
