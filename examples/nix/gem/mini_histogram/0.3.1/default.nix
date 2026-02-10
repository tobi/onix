#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_histogram 0.3.1
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
  pname = "mini_histogram";
  version = "0.3.1";
  src = builtins.path {
    path = ./source;
    name = "mini_histogram-0.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mini_histogram-0.3.1
        cp -r . $dest/gems/mini_histogram-0.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_histogram-0.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_histogram"
      s.version = "0.3.1"
      s.summary = "mini_histogram"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
