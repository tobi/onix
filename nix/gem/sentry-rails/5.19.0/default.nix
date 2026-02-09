#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sentry-rails 5.19.0
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
  pname = "sentry-rails";
  version = "5.19.0";
  src = builtins.path {
    path = ./source;
    name = "sentry-rails-5.19.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/sentry-rails-5.19.0
        cp -r . $dest/gems/sentry-rails-5.19.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sentry-rails-5.19.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sentry-rails"
      s.version = "5.19.0"
      s.summary = "sentry-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
