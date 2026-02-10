#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sigdump 0.2.5
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
  version = "0.2.5";
  src = builtins.path {
    path = ./source;
    name = "sigdump-0.2.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sigdump-0.2.5
        cp -r . $dest/gems/sigdump-0.2.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sigdump-0.2.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sigdump"
      s.version = "0.2.5"
      s.summary = "sigdump"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
