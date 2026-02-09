#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chef-utils 18.9.4
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
  pname = "chef-utils";
  version = "18.9.4";
  src = builtins.path {
    path = ./source;
    name = "chef-utils-18.9.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chef-utils-18.9.4
        cp -r . $dest/gems/chef-utils-18.9.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chef-utils-18.9.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chef-utils"
      s.version = "18.9.4"
      s.summary = "chef-utils"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
