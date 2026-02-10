#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# meta_request 0.8.5
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
  pname = "meta_request";
  version = "0.8.5";
  src = builtins.path {
    path = ./source;
    name = "meta_request-0.8.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/meta_request-0.8.5
        cp -r . $dest/gems/meta_request-0.8.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/meta_request-0.8.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "meta_request"
      s.version = "0.8.5"
      s.summary = "meta_request"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
