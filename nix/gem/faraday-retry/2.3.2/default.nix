#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-retry 2.3.2
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
  pname = "faraday-retry";
  version = "2.3.2";
  src = builtins.path {
    path = ./source;
    name = "faraday-retry-2.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/faraday-retry-2.3.2
        cp -r . $dest/gems/faraday-retry-2.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-retry-2.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-retry"
      s.version = "2.3.2"
      s.summary = "faraday-retry"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
