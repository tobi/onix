#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faker 3.5.2
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
  pname = "faker";
  version = "3.5.2";
  src = builtins.path {
    path = ./source;
    name = "faker-3.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faker-3.5.2
        cp -r . $dest/gems/faker-3.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faker-3.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faker"
      s.version = "3.5.2"
      s.summary = "faker"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["faker"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/faker <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("faker", "faker", "3.5.2")
    BINSTUB
        chmod +x $dest/bin/faker
  '';
}
