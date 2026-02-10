#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activerecord 8.0.4
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
  pname = "activerecord";
  version = "8.0.4";
  src = builtins.path {
    path = ./source;
    name = "activerecord-8.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/activerecord-8.0.4
        cp -r . $dest/gems/activerecord-8.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activerecord-8.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activerecord"
      s.version = "8.0.4"
      s.summary = "activerecord"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
