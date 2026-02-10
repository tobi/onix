#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# einhorn 0.8.2
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
  pname = "einhorn";
  version = "0.8.2";
  src = builtins.path {
    path = ./source;
    name = "einhorn-0.8.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/einhorn-0.8.2
        cp -r . $dest/gems/einhorn-0.8.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/einhorn-0.8.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "einhorn"
      s.version = "0.8.2"
      s.summary = "einhorn"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["einhorn", "einhornsh"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/einhorn <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("einhorn", "einhorn", "0.8.2")
    BINSTUB
        chmod +x $dest/bin/einhorn
        cat > $dest/bin/einhornsh <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("einhorn", "einhornsh", "0.8.2")
    BINSTUB
        chmod +x $dest/bin/einhornsh
  '';
}
