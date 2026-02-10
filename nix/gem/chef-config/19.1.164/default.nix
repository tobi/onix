#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chef-config 19.1.164
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
  pname = "chef-config";
  version = "19.1.164";
  src = builtins.path {
    path = ./source;
    name = "chef-config-19.1.164-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chef-config-19.1.164
        cp -r . $dest/gems/chef-config-19.1.164/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chef-config-19.1.164.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chef-config"
      s.version = "19.1.164"
      s.summary = "chef-config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
