#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# formtastic 5.0.0
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
  version = "5.0.0";
  src = builtins.path {
    path = ./source;
    name = "formtastic-5.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/formtastic-5.0.0
        cp -r . $dest/gems/formtastic-5.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/formtastic-5.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "formtastic"
      s.version = "5.0.0"
      s.summary = "formtastic"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
