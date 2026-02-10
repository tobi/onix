#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# safely_block 0.5.0
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
  pname = "safely_block";
  version = "0.5.0";
  src = builtins.path {
    path = ./source;
    name = "safely_block-0.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/safely_block-0.5.0
        cp -r . $dest/gems/safely_block-0.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/safely_block-0.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "safely_block"
      s.version = "0.5.0"
      s.summary = "safely_block"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
