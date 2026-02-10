#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# snaky_hash 2.0.2
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
  pname = "snaky_hash";
  version = "2.0.2";
  src = builtins.path {
    path = ./source;
    name = "snaky_hash-2.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/snaky_hash-2.0.2
        cp -r . $dest/gems/snaky_hash-2.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/snaky_hash-2.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "snaky_hash"
      s.version = "2.0.2"
      s.summary = "snaky_hash"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
