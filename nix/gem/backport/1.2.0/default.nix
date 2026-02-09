#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backport 1.2.0
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
  pname = "backport";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "backport-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/backport-1.2.0
        cp -r . $dest/gems/backport-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/backport-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "backport"
      s.version = "1.2.0"
      s.summary = "backport"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
