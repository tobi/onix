#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activerecord 7.1.5.2
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
  pname = "activerecord";
  version = "7.1.5.2";
  src = builtins.path {
    path = ./source;
    name = "activerecord-7.1.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/activerecord-7.1.5.2
        cp -r . $dest/gems/activerecord-7.1.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activerecord-7.1.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activerecord"
      s.version = "7.1.5.2"
      s.summary = "activerecord"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
