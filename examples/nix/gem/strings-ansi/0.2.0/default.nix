#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strings-ansi 0.2.0
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
  pname = "strings-ansi";
  version = "0.2.0";
  src = builtins.path {
    path = ./source;
    name = "strings-ansi-0.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/strings-ansi-0.2.0
        cp -r . $dest/gems/strings-ansi-0.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/strings-ansi-0.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "strings-ansi"
      s.version = "0.2.0"
      s.summary = "strings-ansi"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
