#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sexp_processor 4.17.1
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
  pname = "sexp_processor";
  version = "4.17.1";
  src = builtins.path {
    path = ./source;
    name = "sexp_processor-4.17.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sexp_processor-4.17.1
        cp -r . $dest/gems/sexp_processor-4.17.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sexp_processor-4.17.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sexp_processor"
      s.version = "4.17.1"
      s.summary = "sexp_processor"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
