#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_rails 3.0.17
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
  pname = "vite_rails";
  version = "3.0.17";
  src = builtins.path {
    path = ./source;
    name = "vite_rails-3.0.17-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/vite_rails-3.0.17
        cp -r . $dest/gems/vite_rails-3.0.17/
        mkdir -p $dest/specifications
        cat > $dest/specifications/vite_rails-3.0.17.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "vite_rails"
      s.version = "3.0.17"
      s.summary = "vite_rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
