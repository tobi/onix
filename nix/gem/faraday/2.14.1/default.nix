#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday 2.14.1
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
  pname = "faraday";
  version = "2.14.1";
  src = builtins.path {
    path = ./source;
    name = "faraday-2.14.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-2.14.1
        cp -r . $dest/gems/faraday-2.14.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-2.14.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday"
      s.version = "2.14.1"
      s.summary = "faraday"
      s.require_paths = ["lib", "spec/external_adapters"]
      s.files = []
    end
    EOF
  '';
}
