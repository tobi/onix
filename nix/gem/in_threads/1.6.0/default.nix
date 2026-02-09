#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# in_threads 1.6.0
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
  pname = "in_threads";
  version = "1.6.0";
  src = builtins.path {
    path = ./source;
    name = "in_threads-1.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/in_threads-1.6.0
        cp -r . $dest/gems/in_threads-1.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/in_threads-1.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "in_threads"
      s.version = "1.6.0"
      s.summary = "in_threads"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
