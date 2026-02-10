#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-openstack 1.1.5
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
  pname = "fog-openstack";
  version = "1.1.5";
  src = builtins.path {
    path = ./source;
    name = "fog-openstack-1.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-openstack-1.1.5
        cp -r . $dest/gems/fog-openstack-1.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-openstack-1.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-openstack"
      s.version = "1.1.5"
      s.summary = "fog-openstack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
