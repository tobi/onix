#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wicked_pdf 2.8.1
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
  pname = "wicked_pdf";
  version = "2.8.1";
  src = builtins.path {
    path = ./source;
    name = "wicked_pdf-2.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/wicked_pdf-2.8.1
        cp -r . $dest/gems/wicked_pdf-2.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wicked_pdf-2.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wicked_pdf"
      s.version = "2.8.1"
      s.summary = "wicked_pdf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
