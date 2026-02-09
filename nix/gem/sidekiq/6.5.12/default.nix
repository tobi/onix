#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq 6.5.12
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
  version = "6.5.12";
  src = builtins.path {
    path = ./source;
    name = "sidekiq-6.5.12-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sidekiq-6.5.12
        cp -r . $dest/gems/sidekiq-6.5.12/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sidekiq-6.5.12.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sidekiq"
      s.version = "6.5.12"
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
    load Gem.bin_path("sidekiq", "sidekiq", "6.5.12")
    BINSTUB
        chmod +x $dest/bin/sidekiq
        cat > $dest/bin/sidekiqmon <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sidekiq", "sidekiqmon", "6.5.12")
    BINSTUB
        chmod +x $dest/bin/sidekiqmon
  '';
}
