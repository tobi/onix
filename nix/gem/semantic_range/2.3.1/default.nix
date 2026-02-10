#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# semantic_range 2.3.1
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
  pname = "semantic_range";
  version = "2.3.1";
  src = builtins.path {
    path = ./source;
    name = "semantic_range-2.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/semantic_range-2.3.1
        cp -r . $dest/gems/semantic_range-2.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/semantic_range-2.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "semantic_range"
      s.version = "2.3.1"
      s.summary = "semantic_range"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
