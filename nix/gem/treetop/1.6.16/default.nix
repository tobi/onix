#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# treetop 1.6.16
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
  pname = "treetop";
  version = "1.6.16";
  src = builtins.path {
    path = ./source;
    name = "treetop-1.6.16-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/treetop-1.6.16
        cp -r . $dest/gems/treetop-1.6.16/
        mkdir -p $dest/specifications
        cat > $dest/specifications/treetop-1.6.16.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "treetop"
      s.version = "1.6.16"
      s.summary = "treetop"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["tt"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/tt <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("treetop", "tt", "1.6.16")
    BINSTUB
        chmod +x $dest/bin/tt
  '';
}
