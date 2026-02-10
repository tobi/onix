#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-search 1.0.1
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
  pname = "cocoapods-search";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-search-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-search-1.0.1
        cp -r . $dest/gems/cocoapods-search-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-search-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-search"
      s.version = "1.0.1"
      s.summary = "cocoapods-search"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
