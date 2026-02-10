#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gem-release 2.2.4
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
  pname = "gem-release";
  version = "2.2.4";
  src = builtins.path {
    path = ./source;
    name = "gem-release-2.2.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gem-release-2.2.4
        cp -r . $dest/gems/gem-release-2.2.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gem-release-2.2.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gem-release"
      s.version = "2.2.4"
      s.summary = "gem-release"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
