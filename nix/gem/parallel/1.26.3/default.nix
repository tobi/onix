#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel 1.26.3
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
  pname = "parallel";
  version = "1.26.3";
  src = builtins.path {
    path = ./source;
    name = "parallel-1.26.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/parallel-1.26.3
        cp -r . $dest/gems/parallel-1.26.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/parallel-1.26.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "parallel"
      s.version = "1.26.3"
      s.summary = "parallel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
