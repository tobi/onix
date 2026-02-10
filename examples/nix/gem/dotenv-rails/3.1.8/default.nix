#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv-rails 3.1.8
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
  pname = "dotenv-rails";
  version = "3.1.8";
  src = builtins.path {
    path = ./source;
    name = "dotenv-rails-3.1.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dotenv-rails-3.1.8
        cp -r . $dest/gems/dotenv-rails-3.1.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dotenv-rails-3.1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dotenv-rails"
      s.version = "3.1.8"
      s.summary = "dotenv-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
