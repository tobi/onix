#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-scheduler 6.0.1
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
  pname = "sidekiq-scheduler";
  version = "6.0.1";
  src = builtins.path {
    path = ./source;
    name = "sidekiq-scheduler-6.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sidekiq-scheduler-6.0.1
        cp -r . $dest/gems/sidekiq-scheduler-6.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sidekiq-scheduler-6.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sidekiq-scheduler"
      s.version = "6.0.1"
      s.summary = "sidekiq-scheduler"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
