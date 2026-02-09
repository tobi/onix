#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq 8.0.10
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
  pname = "sidekiq";
  version = "8.0.10";
  src = builtins.path {
    path = ./source;
    name = "sidekiq-8.0.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sidekiq-8.0.10
        cp -r . $dest/gems/sidekiq-8.0.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sidekiq-8.0.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sidekiq"
      s.version = "8.0.10"
      s.summary = "sidekiq"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["sidekiq", "sidekiqmon"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/sidekiq <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sidekiq", "sidekiq", "8.0.10")
    BINSTUB
        chmod +x $dest/bin/sidekiq
        cat > $dest/bin/sidekiqmon <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sidekiq", "sidekiqmon", "8.0.10")
    BINSTUB
        chmod +x $dest/bin/sidekiqmon
  '';
}
