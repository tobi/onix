#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# Git: useragent @ 433ca320a42d
# URI: https://github.com/basecamp/useragent
# Gems: useragent
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "useragent";
  version = "433ca320a42d";
  src = builtins.path {
    path = ./source;
    name = "useragent-433ca320a42d-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}/bundler/gems/useragent-433ca320a42d
        mkdir -p $dest
        cp -r . $dest/
        cat > $dest/useragent.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "useragent"
      s.version = "0.16.11"
      s.summary = "useragent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
