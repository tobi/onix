#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kamal 2.10.1
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
  pname = "kamal";
  version = "2.10.1";
  src = builtins.path {
    path = ./source;
    name = "kamal-2.10.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/kamal-2.10.1
        cp -r . $dest/gems/kamal-2.10.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/kamal-2.10.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kamal"
      s.version = "2.10.1"
      s.summary = "kamal"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["kamal"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/kamal <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("kamal", "kamal", "2.10.1")
    BINSTUB
        chmod +x $dest/bin/kamal
  '';
}
