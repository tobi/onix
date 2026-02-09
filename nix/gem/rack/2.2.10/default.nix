#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack 2.2.10
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
  pname = "rack";
  version = "2.2.10";
  src = builtins.path {
    path = ./source;
    name = "rack-2.2.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-2.2.10
        cp -r . $dest/gems/rack-2.2.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-2.2.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack"
      s.version = "2.2.10"
      s.summary = "rack"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rackup"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rackup <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rack", "rackup", "2.2.10")
    BINSTUB
        chmod +x $dest/bin/rackup
  '';
}
