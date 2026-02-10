#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sys-uname 1.4.0
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
  pname = "sys-uname";
  version = "1.4.0";
  src = builtins.path {
    path = ./source;
    name = "sys-uname-1.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sys-uname-1.4.0
        cp -r . $dest/gems/sys-uname-1.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sys-uname-1.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sys-uname"
      s.version = "1.4.0"
      s.summary = "sys-uname"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
