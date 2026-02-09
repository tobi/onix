#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-http-cache 2.5.0
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
  pname = "faraday-http-cache";
  version = "2.5.0";
  src = builtins.path {
    path = ./source;
    name = "faraday-http-cache-2.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-http-cache-2.5.0
        cp -r . $dest/gems/faraday-http-cache-2.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-http-cache-2.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-http-cache"
      s.version = "2.5.0"
      s.summary = "faraday-http-cache"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
