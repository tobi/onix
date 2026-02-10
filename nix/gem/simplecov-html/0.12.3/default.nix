#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov-html 0.12.3
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
  pname = "simplecov-html";
  version = "0.12.3";
  src = builtins.path {
    path = ./source;
    name = "simplecov-html-0.12.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simplecov-html-0.12.3
        cp -r . $dest/gems/simplecov-html-0.12.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simplecov-html-0.12.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simplecov-html"
      s.version = "0.12.3"
      s.summary = "simplecov-html"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
