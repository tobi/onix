#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring 4.1.1
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
  pname = "spring";
  version = "4.1.1";
  src = builtins.path {
    path = ./source;
    name = "spring-4.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/spring-4.1.1
        cp -r . $dest/gems/spring-4.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spring-4.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spring"
      s.version = "4.1.1"
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
    load Gem.bin_path("spring", "spring", "4.1.1")
    BINSTUB
        chmod +x $dest/bin/spring
  '';
}
