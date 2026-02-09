#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyzip 3.0.0.rc2
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
  pname = "rubyzip";
  version = "3.0.0.rc2";
  src = builtins.path {
    path = ./source;
    name = "rubyzip-3.0.0.rc2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubyzip-3.0.0.rc2
        cp -r . $dest/gems/rubyzip-3.0.0.rc2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubyzip-3.0.0.rc2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubyzip"
      s.version = "3.0.0.rc2"
      s.summary = "rubyzip"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
