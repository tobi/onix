#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elastic-apm 4.6.2
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
  pname = "elastic-apm";
  version = "4.6.2";
  src = builtins.path {
    path = ./source;
    name = "elastic-apm-4.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elastic-apm-4.6.2
        cp -r . $dest/gems/elastic-apm-4.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elastic-apm-4.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elastic-apm"
      s.version = "4.6.2"
      s.summary = "elastic-apm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
