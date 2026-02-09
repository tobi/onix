#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple_form 5.4.1
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
  pname = "simple_form";
  version = "5.4.1";
  src = builtins.path {
    path = ./source;
    name = "simple_form-5.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simple_form-5.4.1
        cp -r . $dest/gems/simple_form-5.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simple_form-5.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simple_form"
      s.version = "5.4.1"
      s.summary = "simple_form"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
