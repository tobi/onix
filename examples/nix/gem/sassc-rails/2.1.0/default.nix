#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sassc-rails 2.1.0
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
  pname = "sassc-rails";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "sassc-rails-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sassc-rails-2.1.0
        cp -r . $dest/gems/sassc-rails-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sassc-rails-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sassc-rails"
      s.version = "2.1.0"
      s.summary = "sassc-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
