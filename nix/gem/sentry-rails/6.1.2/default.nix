#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sentry-rails 6.1.2
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
  pname = "sentry-rails";
  version = "6.1.2";
  src = builtins.path {
    path = ./source;
    name = "sentry-rails-6.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sentry-rails-6.1.2
        cp -r . $dest/gems/sentry-rails-6.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sentry-rails-6.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sentry-rails"
      s.version = "6.1.2"
      s.summary = "sentry-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
