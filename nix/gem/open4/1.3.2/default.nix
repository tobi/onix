#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# open4 1.3.2
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
  pname = "open4";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "open4-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/open4-1.3.2
        cp -r . $dest/gems/open4-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/open4-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "open4"
      s.version = "1.3.2"
      s.summary = "open4"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
