#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# memoist 0.16.1
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
  pname = "memoist";
  version = "0.16.1";
  src = builtins.path {
    path = ./source;
    name = "memoist-0.16.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/memoist-0.16.1
        cp -r . $dest/gems/memoist-0.16.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/memoist-0.16.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "memoist"
      s.version = "0.16.1"
      s.summary = "memoist"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
