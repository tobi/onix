#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# down 5.4.0
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
  pname = "down";
  version = "5.4.0";
  src = builtins.path {
    path = ./source;
    name = "down-5.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/down-5.4.0
        cp -r . $dest/gems/down-5.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/down-5.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "down"
      s.version = "5.4.0"
      s.summary = "down"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
