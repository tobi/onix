#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring 4.4.2
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
  pname = "spring";
  version = "4.4.2";
  src = builtins.path {
    path = ./source;
    name = "spring-4.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/spring-4.4.2
        cp -r . $dest/gems/spring-4.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spring-4.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spring"
      s.version = "4.4.2"
      s.summary = "spring"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["spring"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/spring <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("spring", "spring", "4.4.2")
    BINSTUB
        chmod +x $dest/bin/spring
  '';
}
