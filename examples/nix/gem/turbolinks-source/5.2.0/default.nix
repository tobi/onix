#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbolinks-source 5.2.0
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
  pname = "turbolinks-source";
  version = "5.2.0";
  src = builtins.path {
    path = ./source;
    name = "turbolinks-source-5.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/turbolinks-source-5.2.0
        cp -r . $dest/gems/turbolinks-source-5.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/turbolinks-source-5.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "turbolinks-source"
      s.version = "5.2.0"
      s.summary = "turbolinks-source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
