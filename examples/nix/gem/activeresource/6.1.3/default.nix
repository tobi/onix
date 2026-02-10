#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activeresource 6.1.3
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
  pname = "activeresource";
  version = "6.1.3";
  src = builtins.path {
    path = ./source;
    name = "activeresource-6.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/activeresource-6.1.3
        cp -r . $dest/gems/activeresource-6.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activeresource-6.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activeresource"
      s.version = "6.1.3"
      s.summary = "activeresource"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
