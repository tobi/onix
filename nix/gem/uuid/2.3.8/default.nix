#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uuid 2.3.8
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
  pname = "uuid";
  version = "2.3.8";
  src = builtins.path {
    path = ./source;
    name = "uuid-2.3.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/uuid-2.3.8
        cp -r . $dest/gems/uuid-2.3.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uuid-2.3.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uuid"
      s.version = "2.3.8"
      s.summary = "uuid"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["uuid"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/uuid <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("uuid", "uuid", "2.3.8")
    BINSTUB
        chmod +x $dest/bin/uuid
  '';
}
