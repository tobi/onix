#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_nested_set 3.9.0
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
  pname = "awesome_nested_set";
  version = "3.9.0";
  src = builtins.path {
    path = ./source;
    name = "awesome_nested_set-3.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/awesome_nested_set-3.9.0
        cp -r . $dest/gems/awesome_nested_set-3.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/awesome_nested_set-3.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "awesome_nested_set"
      s.version = "3.9.0"
      s.summary = "awesome_nested_set"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
