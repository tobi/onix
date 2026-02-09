#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-controller-testing 1.0.4
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
  pname = "rails-controller-testing";
  version = "1.0.4";
  src = builtins.path {
    path = ./source;
    name = "rails-controller-testing-1.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rails-controller-testing-1.0.4
        cp -r . $dest/gems/rails-controller-testing-1.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rails-controller-testing-1.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rails-controller-testing"
      s.version = "1.0.4"
      s.summary = "rails-controller-testing"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
