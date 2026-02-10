#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# foreman 0.88.1
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
  pname = "foreman";
  version = "0.88.1";
  src = builtins.path {
    path = ./source;
    name = "foreman-0.88.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/foreman-0.88.1
        cp -r . $dest/gems/foreman-0.88.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/foreman-0.88.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "foreman"
      s.version = "0.88.1"
      s.summary = "foreman"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["foreman"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/foreman <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("foreman", "foreman", "0.88.1")
    BINSTUB
        chmod +x $dest/bin/foreman
  '';
}
