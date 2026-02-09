#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flag_shih_tzu 0.3.23
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
  pname = "flag_shih_tzu";
  version = "0.3.23";
  src = builtins.path {
    path = ./source;
    name = "flag_shih_tzu-0.3.23-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/flag_shih_tzu-0.3.23
        cp -r . $dest/gems/flag_shih_tzu-0.3.23/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flag_shih_tzu-0.3.23.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flag_shih_tzu"
      s.version = "0.3.23"
      s.summary = "flag_shih_tzu"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["test.bash"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/test.bash <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("flag_shih_tzu", "test.bash", "0.3.23")
    BINSTUB
        chmod +x $dest/bin/test.bash
  '';
}
