#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth2 1.4.11
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
  pname = "oauth2";
  version = "1.4.11";
  src = builtins.path {
    path = ./source;
    name = "oauth2-1.4.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/oauth2-1.4.11
        cp -r . $dest/gems/oauth2-1.4.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/oauth2-1.4.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "oauth2"
      s.version = "1.4.11"
      s.summary = "oauth2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
