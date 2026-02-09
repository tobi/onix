#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-rails_csrf_protection 1.0.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "omniauth-rails_csrf_protection";
  version = "1.0.2";
  src = builtins.path {
    path = ./source;
    name = "omniauth-rails_csrf_protection-1.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/omniauth-rails_csrf_protection-1.0.2
        cp -r . $dest/gems/omniauth-rails_csrf_protection-1.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-rails_csrf_protection-1.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-rails_csrf_protection"
      s.version = "1.0.2"
      s.summary = "omniauth-rails_csrf_protection"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
