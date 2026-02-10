#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel 1.26.2
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
  version = "1.26.2";
  src = builtins.path {
    path = ./source;
    name = "parallel-1.26.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/parallel-1.26.2
        cp -r . $dest/gems/parallel-1.26.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/parallel-1.26.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "parallel"
      s.version = "1.26.2"
      s.summary = "parallel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
