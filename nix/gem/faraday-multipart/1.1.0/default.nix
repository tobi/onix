#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-multipart 1.1.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "faraday-multipart";
  version = "1.1.0";
  src = builtins.path {
    path = ./source;
    name = "faraday-multipart-1.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-multipart-1.1.0
        cp -r . $dest/gems/faraday-multipart-1.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-multipart-1.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-multipart"
      s.version = "1.1.0"
      s.summary = "faraday-multipart"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
