#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sys-filesystem 1.5.3
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
  pname = "sys-filesystem";
  version = "1.5.3";
  src = builtins.path {
    path = ./source;
    name = "sys-filesystem-1.5.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sys-filesystem-1.5.3
        cp -r . $dest/gems/sys-filesystem-1.5.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sys-filesystem-1.5.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sys-filesystem"
      s.version = "1.5.3"
      s.summary = "sys-filesystem"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
