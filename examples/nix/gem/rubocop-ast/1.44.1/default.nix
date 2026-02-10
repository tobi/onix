#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-ast 1.44.1
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
  pname = "rubocop-ast";
  version = "1.44.1";
  src = builtins.path {
    path = ./source;
    name = "rubocop-ast-1.44.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-ast-1.44.1
        cp -r . $dest/gems/rubocop-ast-1.44.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-ast-1.44.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-ast"
      s.version = "1.44.1"
      s.summary = "rubocop-ast"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
