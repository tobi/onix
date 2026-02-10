#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbolinks 5.2.0
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
  version = "5.2.0";
  src = builtins.path {
    path = ./source;
    name = "turbolinks-5.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/turbolinks-5.2.0
        cp -r . $dest/gems/turbolinks-5.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/turbolinks-5.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "turbolinks"
      s.version = "5.2.0"
      s.summary = "turbolinks"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
