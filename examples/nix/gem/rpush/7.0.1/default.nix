#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpush 7.0.1
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
  pname = "rpush";
  version = "7.0.1";
  src = builtins.path {
    path = ./source;
    name = "rpush-7.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rpush-7.0.1
        cp -r . $dest/gems/rpush-7.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rpush-7.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rpush"
      s.version = "7.0.1"
      s.summary = "rpush"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rpush"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rpush <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rpush", "rpush", "7.0.1")
    BINSTUB
        chmod +x $dest/bin/rpush
  '';
}
