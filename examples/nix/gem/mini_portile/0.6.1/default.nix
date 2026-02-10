#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_portile 0.6.1
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
  pname = "mini_portile";
  version = "0.6.1";
  src = builtins.path {
    path = ./source;
    name = "mini_portile-0.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mini_portile-0.6.1
        cp -r . $dest/gems/mini_portile-0.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_portile-0.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_portile"
      s.version = "0.6.1"
      s.summary = "mini_portile"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
