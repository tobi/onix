#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# web-console 4.2.0
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
  pname = "web-console";
  version = "4.2.0";
  src = builtins.path {
    path = ./source;
    name = "web-console-4.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/web-console-4.2.0
        cp -r . $dest/gems/web-console-4.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/web-console-4.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "web-console"
      s.version = "4.2.0"
      s.summary = "web-console"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
