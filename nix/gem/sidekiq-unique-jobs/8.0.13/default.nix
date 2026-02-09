#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-unique-jobs 8.0.13
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
  pname = "sidekiq-unique-jobs";
  version = "8.0.13";
  src = builtins.path {
    path = ./source;
    name = "sidekiq-unique-jobs-8.0.13-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sidekiq-unique-jobs-8.0.13
        cp -r . $dest/gems/sidekiq-unique-jobs-8.0.13/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sidekiq-unique-jobs-8.0.13.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sidekiq-unique-jobs"
      s.version = "8.0.13"
      s.summary = "sidekiq-unique-jobs"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["uniquejobs"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/uniquejobs <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sidekiq-unique-jobs", "uniquejobs", "8.0.13")
    BINSTUB
        chmod +x $dest/bin/uniquejobs
  '';
}
