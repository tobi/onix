#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zeitwerk 2.7.3
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
  pname = "zeitwerk";
  version = "2.7.3";
  src = builtins.path {
    path = ./source;
    name = "zeitwerk-2.7.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/zeitwerk-2.7.3
        cp -r . $dest/gems/zeitwerk-2.7.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/zeitwerk-2.7.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "zeitwerk"
      s.version = "2.7.3"
      s.summary = "zeitwerk"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
