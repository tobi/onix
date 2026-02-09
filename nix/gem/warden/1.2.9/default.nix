#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# warden 1.2.9
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
  pname = "warden";
  version = "1.2.9";
  src = builtins.path {
    path = ./source;
    name = "warden-1.2.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/warden-1.2.9
        cp -r . $dest/gems/warden-1.2.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/warden-1.2.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "warden"
      s.version = "1.2.9"
      s.summary = "warden"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
