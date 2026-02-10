#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# version_gem 1.1.8
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
  version = "1.1.8";
  src = builtins.path {
    path = ./source;
    name = "version_gem-1.1.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/version_gem-1.1.8
        cp -r . $dest/gems/version_gem-1.1.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/version_gem-1.1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "version_gem"
      s.version = "1.1.8"
      s.summary = "version_gem"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
