#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gh_inspector 1.1.1
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
  pname = "gh_inspector";
  version = "1.1.1";
  src = builtins.path {
    path = ./source;
    name = "gh_inspector-1.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gh_inspector-1.1.1
        cp -r . $dest/gems/gh_inspector-1.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gh_inspector-1.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gh_inspector"
      s.version = "1.1.1"
      s.summary = "gh_inspector"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
