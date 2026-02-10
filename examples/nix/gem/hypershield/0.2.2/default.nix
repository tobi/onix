#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hypershield 0.2.2
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
  pname = "hypershield";
  version = "0.2.2";
  src = builtins.path {
    path = ./source;
    name = "hypershield-0.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/hypershield-0.2.2
        cp -r . $dest/gems/hypershield-0.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/hypershield-0.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "hypershield"
      s.version = "0.2.2"
      s.summary = "hypershield"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
