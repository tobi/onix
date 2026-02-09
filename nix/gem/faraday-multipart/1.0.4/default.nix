#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-multipart 1.0.4
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
  pname = "faraday-multipart";
  version = "1.0.4";
  src = builtins.path {
    path = ./source;
    name = "faraday-multipart-1.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/faraday-multipart-1.0.4
        cp -r . $dest/gems/faraday-multipart-1.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-multipart-1.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-multipart"
      s.version = "1.0.4"
      s.summary = "faraday-multipart"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
