#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# octokit 5.6.1
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
  version = "5.6.1";
  src = builtins.path {
    path = ./source;
    name = "octokit-5.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/octokit-5.6.1
        cp -r . $dest/gems/octokit-5.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/octokit-5.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "octokit"
      s.version = "5.6.1"
      s.summary = "octokit"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
