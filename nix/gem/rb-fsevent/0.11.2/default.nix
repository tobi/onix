#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-fsevent 0.11.2
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
  pname = "rb-fsevent";
  version = "0.11.2";
  src = builtins.path {
    path = ./source;
    name = "rb-fsevent-0.11.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rb-fsevent-0.11.2
        cp -r . $dest/gems/rb-fsevent-0.11.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rb-fsevent-0.11.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rb-fsevent"
      s.version = "0.11.2"
      s.summary = "rb-fsevent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
