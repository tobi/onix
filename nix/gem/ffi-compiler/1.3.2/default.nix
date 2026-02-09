#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi-compiler 1.3.2
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
  pname = "ffi-compiler";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "ffi-compiler-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ffi-compiler-1.3.2
        cp -r . $dest/gems/ffi-compiler-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ffi-compiler-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ffi-compiler"
      s.version = "1.3.2"
      s.summary = "ffi-compiler"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
