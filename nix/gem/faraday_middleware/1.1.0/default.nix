#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday_middleware 1.1.0
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
  pname = "faraday_middleware";
  version = "1.1.0";
  src = builtins.path {
    path = ./source;
    name = "faraday_middleware-1.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday_middleware-1.1.0
        cp -r . $dest/gems/faraday_middleware-1.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday_middleware-1.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday_middleware"
      s.version = "1.1.0"
      s.summary = "faraday_middleware"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
