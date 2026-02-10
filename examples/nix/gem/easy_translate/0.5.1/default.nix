#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# easy_translate 0.5.1
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
  pname = "easy_translate";
  version = "0.5.1";
  src = builtins.path {
    path = ./source;
    name = "easy_translate-0.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/easy_translate-0.5.1
        cp -r . $dest/gems/easy_translate-0.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/easy_translate-0.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "easy_translate"
      s.version = "0.5.1"
      s.summary = "easy_translate"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
