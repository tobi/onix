#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sorted_set 1.0.2
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
  pname = "sorted_set";
  version = "1.0.2";
  src = builtins.path {
    path = ./source;
    name = "sorted_set-1.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sorted_set-1.0.2
        cp -r . $dest/gems/sorted_set-1.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sorted_set-1.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sorted_set"
      s.version = "1.0.2"
      s.summary = "sorted_set"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
