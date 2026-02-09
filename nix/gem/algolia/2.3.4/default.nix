#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algolia 2.3.4
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
  pname = "algolia";
  version = "2.3.4";
  src = builtins.path {
    path = ./source;
    name = "algolia-2.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/algolia-2.3.4
        cp -r . $dest/gems/algolia-2.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/algolia-2.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "algolia"
      s.version = "2.3.4"
      s.summary = "algolia"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
