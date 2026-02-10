#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sigdump 0.2.4
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
  pname = "sigdump";
  version = "0.2.4";
  src = builtins.path {
    path = ./source;
    name = "sigdump-0.2.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sigdump-0.2.4
        cp -r . $dest/gems/sigdump-0.2.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sigdump-0.2.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sigdump"
      s.version = "0.2.4"
      s.summary = "sigdump"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
