#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rtlcss 0.2.1
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
  pname = "rtlcss";
  version = "0.2.1";
  src = builtins.path {
    path = ./source;
    name = "rtlcss-0.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rtlcss-0.2.1
        cp -r . $dest/gems/rtlcss-0.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rtlcss-0.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rtlcss"
      s.version = "0.2.1"
      s.summary = "rtlcss"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
