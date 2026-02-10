#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailer 8.1.2
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
  pname = "actionmailer";
  version = "8.1.2";
  src = builtins.path {
    path = ./source;
    name = "actionmailer-8.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/actionmailer-8.1.2
        cp -r . $dest/gems/actionmailer-8.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionmailer-8.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionmailer"
      s.version = "8.1.2"
      s.summary = "actionmailer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
