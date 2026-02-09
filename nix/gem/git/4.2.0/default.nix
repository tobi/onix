#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# git 4.2.0
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
  pname = "git";
  version = "4.2.0";
  src = builtins.path {
    path = ./source;
    name = "git-4.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/git-4.2.0
        cp -r . $dest/gems/git-4.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/git-4.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "git"
      s.version = "4.2.0"
      s.summary = "git"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
