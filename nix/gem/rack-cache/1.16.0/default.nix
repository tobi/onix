#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-cache 1.16.0
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
  pname = "rack-cache";
  version = "1.16.0";
  src = builtins.path {
    path = ./source;
    name = "rack-cache-1.16.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-cache-1.16.0
        cp -r . $dest/gems/rack-cache-1.16.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-cache-1.16.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-cache"
      s.version = "1.16.0"
      s.summary = "rack-cache"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
