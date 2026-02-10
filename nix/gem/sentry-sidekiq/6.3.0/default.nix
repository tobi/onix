#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sentry-sidekiq 6.3.0
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
  pname = "sentry-sidekiq";
  version = "6.3.0";
  src = builtins.path {
    path = ./source;
    name = "sentry-sidekiq-6.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sentry-sidekiq-6.3.0
        cp -r . $dest/gems/sentry-sidekiq-6.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sentry-sidekiq-6.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sentry-sidekiq"
      s.version = "6.3.0"
      s.summary = "sentry-sidekiq"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
