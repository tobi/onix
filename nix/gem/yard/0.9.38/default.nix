#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard 0.9.38
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
  pname = "yard";
  version = "0.9.38";
  src = builtins.path {
    path = ./source;
    name = "yard-0.9.38-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/yard-0.9.38
        cp -r . $dest/gems/yard-0.9.38/
        mkdir -p $dest/specifications
        cat > $dest/specifications/yard-0.9.38.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "yard"
      s.version = "0.9.38"
      s.summary = "yard"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["yard", "yardoc", "yri"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/yard <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("yard", "yard", "0.9.38")
    BINSTUB
        chmod +x $dest/bin/yard
        cat > $dest/bin/yardoc <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("yard", "yardoc", "0.9.38")
    BINSTUB
        chmod +x $dest/bin/yardoc
        cat > $dest/bin/yri <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("yard", "yri", "0.9.38")
    BINSTUB
        chmod +x $dest/bin/yri
  '';
}
