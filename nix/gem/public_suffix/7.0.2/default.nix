#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# public_suffix 7.0.2
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
  pname = "public_suffix";
  version = "7.0.2";
  src = builtins.path {
    path = ./source;
    name = "public_suffix-7.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/public_suffix-7.0.2
        cp -r . $dest/gems/public_suffix-7.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/public_suffix-7.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "public_suffix"
      s.version = "7.0.2"
      s.summary = "public_suffix"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
