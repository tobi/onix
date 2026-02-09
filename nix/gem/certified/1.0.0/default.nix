#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# certified 1.0.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "certified";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "certified-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/certified-1.0.0
        cp -r . $dest/gems/certified-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/certified-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "certified"
      s.version = "1.0.0"
      s.summary = "certified"
      s.require_paths = ["."]
      s.bindir = "bin"
      s.executables = ["certified-update"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/certified-update <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("certified", "certified-update", "1.0.0")
    BINSTUB
        chmod +x $dest/bin/certified-update
  '';
}
