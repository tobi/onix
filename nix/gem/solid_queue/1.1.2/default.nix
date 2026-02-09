#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_queue 1.1.2
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
  pname = "solid_queue";
  version = "1.1.2";
  src = builtins.path {
    path = ./source;
    name = "solid_queue-1.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/solid_queue-1.1.2
        cp -r . $dest/gems/solid_queue-1.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/solid_queue-1.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "solid_queue"
      s.version = "1.1.2"
      s.summary = "solid_queue"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
