#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capistrano 3.19.1
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
  pname = "capistrano";
  version = "3.19.1";
  src = builtins.path {
    path = ./source;
    name = "capistrano-3.19.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/capistrano-3.19.1
        cp -r . $dest/gems/capistrano-3.19.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/capistrano-3.19.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "capistrano"
      s.version = "3.19.1"
      s.summary = "capistrano"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["cap", "capify"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/cap <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("capistrano", "cap", "3.19.1")
    BINSTUB
        chmod +x $dest/bin/cap
        cat > $dest/bin/capify <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("capistrano", "capify", "3.19.1")
    BINSTUB
        chmod +x $dest/bin/capify
  '';
}
