#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# valid_email2 5.2.6
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
  pname = "valid_email2";
  version = "5.2.6";
  src = builtins.path {
    path = ./source;
    name = "valid_email2-5.2.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/valid_email2-5.2.6
        cp -r . $dest/gems/valid_email2-5.2.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/valid_email2-5.2.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "valid_email2"
      s.version = "5.2.6"
      s.summary = "valid_email2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
