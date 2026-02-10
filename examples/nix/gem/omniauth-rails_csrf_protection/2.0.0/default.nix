#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-rails_csrf_protection 2.0.0
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
  pname = "omniauth-rails_csrf_protection";
  version = "2.0.0";
  src = builtins.path {
    path = ./source;
    name = "omniauth-rails_csrf_protection-2.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-rails_csrf_protection-2.0.0
        cp -r . $dest/gems/omniauth-rails_csrf_protection-2.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-rails_csrf_protection-2.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-rails_csrf_protection"
      s.version = "2.0.0"
      s.summary = "omniauth-rails_csrf_protection"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
