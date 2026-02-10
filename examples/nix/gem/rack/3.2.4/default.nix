#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack 3.2.4
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
  pname = "rack";
  version = "3.2.4";
  src = builtins.path {
    path = ./source;
    name = "rack-3.2.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-3.2.4
        cp -r . $dest/gems/rack-3.2.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-3.2.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack"
      s.version = "3.2.4"
      s.summary = "rack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
