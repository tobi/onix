#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# typhoeus 1.4.0
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
  pname = "typhoeus";
  version = "1.4.0";
  src = builtins.path {
    path = ./source;
    name = "typhoeus-1.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/typhoeus-1.4.0
        cp -r . $dest/gems/typhoeus-1.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/typhoeus-1.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "typhoeus"
      s.version = "1.4.0"
      s.summary = "typhoeus"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
