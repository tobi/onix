#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# binding_of_caller 1.0.1
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
  pname = "binding_of_caller";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "binding_of_caller-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/binding_of_caller-1.0.1
        cp -r . $dest/gems/binding_of_caller-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/binding_of_caller-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "binding_of_caller"
      s.version = "1.0.1"
      s.summary = "binding_of_caller"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
