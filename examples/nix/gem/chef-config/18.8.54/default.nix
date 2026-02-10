#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chef-config 18.8.54
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
  version = "18.8.54";
  src = builtins.path {
    path = ./source;
    name = "chef-config-18.8.54-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chef-config-18.8.54
        cp -r . $dest/gems/chef-config-18.8.54/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chef-config-18.8.54.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chef-config"
      s.version = "18.8.54"
      s.summary = "chef-config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
