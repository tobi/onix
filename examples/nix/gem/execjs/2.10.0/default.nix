#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# execjs 2.10.0
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
  pname = "execjs";
  version = "2.10.0";
  src = builtins.path {
    path = ./source;
    name = "execjs-2.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/execjs-2.10.0
        cp -r . $dest/gems/execjs-2.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/execjs-2.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "execjs"
      s.version = "2.10.0"
      s.summary = "execjs"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
