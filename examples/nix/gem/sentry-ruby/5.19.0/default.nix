#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sentry-ruby 5.19.0
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
  pname = "sentry-ruby";
  version = "5.19.0";
  src = builtins.path {
    path = ./source;
    name = "sentry-ruby-5.19.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sentry-ruby-5.19.0
        cp -r . $dest/gems/sentry-ruby-5.19.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sentry-ruby-5.19.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sentry-ruby"
      s.version = "5.19.0"
      s.summary = "sentry-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
