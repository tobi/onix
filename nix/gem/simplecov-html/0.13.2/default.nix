#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov-html 0.13.2
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
  pname = "simplecov-html";
  version = "0.13.2";
  src = builtins.path {
    path = ./source;
    name = "simplecov-html-0.13.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simplecov-html-0.13.2
        cp -r . $dest/gems/simplecov-html-0.13.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simplecov-html-0.13.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simplecov-html"
      s.version = "0.13.2"
      s.summary = "simplecov-html"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
