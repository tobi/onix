#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-encoding 0.0.5
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
  pname = "faraday-encoding";
  version = "0.0.5";
  src = builtins.path {
    path = ./source;
    name = "faraday-encoding-0.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-encoding-0.0.5
        cp -r . $dest/gems/faraday-encoding-0.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-encoding-0.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-encoding"
      s.version = "0.0.5"
      s.summary = "faraday-encoding"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
