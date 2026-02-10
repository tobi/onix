#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fugit 1.12.1
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
  pname = "fugit";
  version = "1.12.1";
  src = builtins.path {
    path = ./source;
    name = "fugit-1.12.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fugit-1.12.1
        cp -r . $dest/gems/fugit-1.12.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fugit-1.12.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fugit"
      s.version = "1.12.1"
      s.summary = "fugit"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
