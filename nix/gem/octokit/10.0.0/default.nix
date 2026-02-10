#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# octokit 10.0.0
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
  pname = "octokit";
  version = "10.0.0";
  src = builtins.path {
    path = ./source;
    name = "octokit-10.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/octokit-10.0.0
        cp -r . $dest/gems/octokit-10.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/octokit-10.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "octokit"
      s.version = "10.0.0"
      s.summary = "octokit"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
