#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-sidekiq 5.2.0
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
  pname = "rspec-sidekiq";
  version = "5.2.0";
  src = builtins.path {
    path = ./source;
    name = "rspec-sidekiq-5.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-sidekiq-5.2.0
        cp -r . $dest/gems/rspec-sidekiq-5.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-sidekiq-5.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-sidekiq"
      s.version = "5.2.0"
      s.summary = "rspec-sidekiq"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
