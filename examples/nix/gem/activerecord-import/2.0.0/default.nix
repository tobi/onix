#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activerecord-import 2.0.0
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
  pname = "activerecord-import";
  version = "2.0.0";
  src = builtins.path {
    path = ./source;
    name = "activerecord-import-2.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/activerecord-import-2.0.0
        cp -r . $dest/gems/activerecord-import-2.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activerecord-import-2.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activerecord-import"
      s.version = "2.0.0"
      s.summary = "activerecord-import"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
