#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# link_header 0.0.8
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
  pname = "link_header";
  version = "0.0.8";
  src = builtins.path {
    path = ./source;
    name = "link_header-0.0.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/link_header-0.0.8
        cp -r . $dest/gems/link_header-0.0.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/link_header-0.0.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "link_header"
      s.version = "0.0.8"
      s.summary = "link_header"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
