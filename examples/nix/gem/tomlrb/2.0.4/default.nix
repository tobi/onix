#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tomlrb 2.0.4
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
  pname = "tomlrb";
  version = "2.0.4";
  src = builtins.path {
    path = ./source;
    name = "tomlrb-2.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tomlrb-2.0.4
        cp -r . $dest/gems/tomlrb-2.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tomlrb-2.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tomlrb"
      s.version = "2.0.4"
      s.summary = "tomlrb"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
