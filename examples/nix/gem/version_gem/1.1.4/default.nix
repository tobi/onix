#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# version_gem 1.1.4
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
  pname = "version_gem";
  version = "1.1.4";
  src = builtins.path {
    path = ./source;
    name = "version_gem-1.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/version_gem-1.1.4
        cp -r . $dest/gems/version_gem-1.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/version_gem-1.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "version_gem"
      s.version = "1.1.4"
      s.summary = "version_gem"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
