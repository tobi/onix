#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# html2text 0.4.0
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
  pname = "html2text";
  version = "0.4.0";
  src = builtins.path {
    path = ./source;
    name = "html2text-0.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/html2text-0.4.0
        cp -r . $dest/gems/html2text-0.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/html2text-0.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "html2text"
      s.version = "0.4.0"
      s.summary = "html2text"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
