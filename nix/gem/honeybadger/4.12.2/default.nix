#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# honeybadger 4.12.2
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
  pname = "honeybadger";
  version = "4.12.2";
  src = builtins.path {
    path = ./source;
    name = "honeybadger-4.12.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/honeybadger-4.12.2
        cp -r . $dest/gems/honeybadger-4.12.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/honeybadger-4.12.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "honeybadger"
      s.version = "4.12.2"
      s.summary = "honeybadger"
      s.require_paths = ["lib", "vendor/capistrano-honeybadger/lib"]
      s.bindir = "bin"
      s.executables = ["honeybadger"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/honeybadger <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("honeybadger", "honeybadger", "4.12.2")
    BINSTUB
        chmod +x $dest/bin/honeybadger
  '';
}
