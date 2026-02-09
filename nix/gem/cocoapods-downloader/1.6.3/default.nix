#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-downloader 1.6.3
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
  pname = "cocoapods-downloader";
  version = "1.6.3";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-downloader-1.6.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-downloader-1.6.3
        cp -r . $dest/gems/cocoapods-downloader-1.6.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-downloader-1.6.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-downloader"
      s.version = "1.6.3"
      s.summary = "cocoapods-downloader"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
