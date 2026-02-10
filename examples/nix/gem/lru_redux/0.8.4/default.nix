#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lru_redux 0.8.4
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
  pname = "lru_redux";
  version = "0.8.4";
  src = builtins.path {
    path = ./source;
    name = "lru_redux-0.8.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/lru_redux-0.8.4
        cp -r . $dest/gems/lru_redux-0.8.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lru_redux-0.8.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lru_redux"
      s.version = "0.8.4"
      s.summary = "lru_redux"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
