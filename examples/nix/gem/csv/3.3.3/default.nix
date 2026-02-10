#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv 3.3.3
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
  pname = "csv";
  version = "3.3.3";
  src = builtins.path {
    path = ./source;
    name = "csv-3.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/csv-3.3.3
        cp -r . $dest/gems/csv-3.3.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/csv-3.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "csv"
      s.version = "3.3.3"
      s.summary = "csv"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["csv-filter"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/csv-filter <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("csv", "csv-filter", "3.3.3")
    BINSTUB
        chmod +x $dest/bin/csv-filter
  '';
}
