#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# declarative 0.0.10
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
  pname = "declarative";
  version = "0.0.10";
  src = builtins.path {
    path = ./source;
    name = "declarative-0.0.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/declarative-0.0.10
        cp -r . $dest/gems/declarative-0.0.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/declarative-0.0.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "declarative"
      s.version = "0.0.10"
      s.summary = "declarative"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
