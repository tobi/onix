#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcodeproj 1.27.0
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
  pname = "xcodeproj";
  version = "1.27.0";
  src = builtins.path {
    path = ./source;
    name = "xcodeproj-1.27.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/xcodeproj-1.27.0
        cp -r . $dest/gems/xcodeproj-1.27.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/xcodeproj-1.27.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "xcodeproj"
      s.version = "1.27.0"
      s.summary = "xcodeproj"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["xcodeproj"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/xcodeproj <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("xcodeproj", "xcodeproj", "1.27.0")
    BINSTUB
        chmod +x $dest/bin/xcodeproj
  '';
}
