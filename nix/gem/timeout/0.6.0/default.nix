#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeout 0.6.0
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
  pname = "timeout";
  version = "0.6.0";
  src = builtins.path {
    path = ./source;
    name = "timeout-0.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/timeout-0.6.0
        cp -r . $dest/gems/timeout-0.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timeout-0.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timeout"
      s.version = "0.6.0"
      s.summary = "timeout"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
