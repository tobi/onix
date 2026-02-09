#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coercible 0.1.0
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
  pname = "coercible";
  version = "0.1.0";
  src = builtins.path {
    path = ./source;
    name = "coercible-0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coercible-0.1.0
        cp -r . $dest/gems/coercible-0.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coercible-0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coercible"
      s.version = "0.1.0"
      s.summary = "coercible"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
