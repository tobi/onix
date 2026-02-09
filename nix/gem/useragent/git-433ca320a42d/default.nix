#
# ╔══════════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate-gemset to refresh  ║
# ╚══════════════════════════════════════════════════════════════════╝
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
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "useragent";
  version = "433ca320a42d";
  src = builtins.fetchGit {
    url = "https://github.com/basecamp/useragent";
    rev = "433ca320a42db1266c4b89df74d0abdb9a880c5e";
    allRefs = true;
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}/bundler/gems/useragent-433ca320a42d
        mkdir -p $dest
        cp -r . $dest/
        rm -rf $dest/.git
        if [ ! -f $dest/useragent.gemspec ] && [ ! -f $dest/useragent/useragent.gemspec ]; then
          cat > $dest/useragent.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "useragent"
      s.version = "0.16.11"
      s.summary = "useragent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        fi
  '';
}
