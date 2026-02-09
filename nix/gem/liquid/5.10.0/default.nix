#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# liquid 5.10.0
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
  pname = "liquid";
  version = "5.10.0";
  src = builtins.path {
    path = ./source;
    name = "liquid-5.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/liquid-5.10.0
        cp -r . $dest/gems/liquid-5.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/liquid-5.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "liquid"
      s.version = "5.10.0"
      s.summary = "liquid"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
