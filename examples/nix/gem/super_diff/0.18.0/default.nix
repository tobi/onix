#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# super_diff 0.18.0
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
  pname = "super_diff";
  version = "0.18.0";
  src = builtins.path {
    path = ./source;
    name = "super_diff-0.18.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/super_diff-0.18.0
        cp -r . $dest/gems/super_diff-0.18.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/super_diff-0.18.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "super_diff"
      s.version = "0.18.0"
      s.summary = "super_diff"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
