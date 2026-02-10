#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# docile 1.3.5
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
  pname = "docile";
  version = "1.3.5";
  src = builtins.path {
    path = ./source;
    name = "docile-1.3.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/docile-1.3.5
        cp -r . $dest/gems/docile-1.3.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/docile-1.3.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "docile"
      s.version = "1.3.5"
      s.summary = "docile"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
