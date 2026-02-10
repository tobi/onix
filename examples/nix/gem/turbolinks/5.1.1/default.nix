#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbolinks 5.1.1
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
  pname = "turbolinks";
  version = "5.1.1";
  src = builtins.path {
    path = ./source;
    name = "turbolinks-5.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/turbolinks-5.1.1
        cp -r . $dest/gems/turbolinks-5.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/turbolinks-5.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "turbolinks"
      s.version = "5.1.1"
      s.summary = "turbolinks"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
