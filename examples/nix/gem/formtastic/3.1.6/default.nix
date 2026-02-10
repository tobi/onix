#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# formtastic 3.1.6
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
  pname = "formtastic";
  version = "3.1.6";
  src = builtins.path {
    path = ./source;
    name = "formtastic-3.1.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/formtastic-3.1.6
        cp -r . $dest/gems/formtastic-3.1.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/formtastic-3.1.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "formtastic"
      s.version = "3.1.6"
      s.summary = "formtastic"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
