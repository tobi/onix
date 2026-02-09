#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeliness 0.5.2
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
  pname = "timeliness";
  version = "0.5.2";
  src = builtins.path {
    path = ./source;
    name = "timeliness-0.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/timeliness-0.5.2
        cp -r . $dest/gems/timeliness-0.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timeliness-0.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timeliness"
      s.version = "0.5.2"
      s.summary = "timeliness"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
