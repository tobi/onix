#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-retry 2.4.0
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
  pname = "faraday-retry";
  version = "2.4.0";
  src = builtins.path {
    path = ./source;
    name = "faraday-retry-2.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-retry-2.4.0
        cp -r . $dest/gems/faraday-retry-2.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-retry-2.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-retry"
      s.version = "2.4.0"
      s.summary = "faraday-retry"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
