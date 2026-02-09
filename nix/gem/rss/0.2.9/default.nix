#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rss 0.2.9
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
  pname = "rss";
  version = "0.2.9";
  src = builtins.path {
    path = ./source;
    name = "rss-0.2.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rss-0.2.9
        cp -r . $dest/gems/rss-0.2.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rss-0.2.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rss"
      s.version = "0.2.9"
      s.summary = "rss"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
