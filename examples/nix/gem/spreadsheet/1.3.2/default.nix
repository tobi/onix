#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spreadsheet 1.3.2
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
  pname = "spreadsheet";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "spreadsheet-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/spreadsheet-1.3.2
        cp -r . $dest/gems/spreadsheet-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spreadsheet-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spreadsheet"
      s.version = "1.3.2"
      s.summary = "spreadsheet"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["xlsopcodes"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/xlsopcodes <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("spreadsheet", "xlsopcodes", "1.3.2")
    BINSTUB
        chmod +x $dest/bin/xlsopcodes
  '';
}
