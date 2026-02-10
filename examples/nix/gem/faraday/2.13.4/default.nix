#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday 2.13.4
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
  version = "2.13.4";
  src = builtins.path {
    path = ./source;
    name = "faraday-2.13.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-2.13.4
        cp -r . $dest/gems/faraday-2.13.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-2.13.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday"
      s.version = "2.13.4"
      s.summary = "faraday"
      s.require_paths = ["lib", "spec/external_adapters"]
      s.files = []
    end
    EOF
  '';
}
