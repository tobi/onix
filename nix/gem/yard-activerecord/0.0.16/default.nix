#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard-activerecord 0.0.16
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
  pname = "yard-activerecord";
  version = "0.0.16";
  src = builtins.path {
    path = ./source;
    name = "yard-activerecord-0.0.16-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/yard-activerecord-0.0.16
        cp -r . $dest/gems/yard-activerecord-0.0.16/
        mkdir -p $dest/specifications
        cat > $dest/specifications/yard-activerecord-0.0.16.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "yard-activerecord"
      s.version = "0.0.16"
      s.summary = "yard-activerecord"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
