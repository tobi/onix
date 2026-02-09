#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-readline 0.5.5
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
  pname = "rb-readline";
  version = "0.5.5";
  src = builtins.path {
    path = ./source;
    name = "rb-readline-0.5.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rb-readline-0.5.5
        cp -r . $dest/gems/rb-readline-0.5.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rb-readline-0.5.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rb-readline"
      s.version = "0.5.5"
      s.summary = "rb-readline"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
