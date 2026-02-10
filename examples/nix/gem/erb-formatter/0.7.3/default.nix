#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erb-formatter 0.7.3
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
  pname = "erb-formatter";
  version = "0.7.3";
  src = builtins.path {
    path = ./source;
    name = "erb-formatter-0.7.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/erb-formatter-0.7.3
        cp -r . $dest/gems/erb-formatter-0.7.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/erb-formatter-0.7.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "erb-formatter"
      s.version = "0.7.3"
      s.summary = "erb-formatter"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["erb-format", "erb-formatter"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/erb-format <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("erb-formatter", "erb-format", "0.7.3")
    BINSTUB
        chmod +x $dest/bin/erb-format
        cat > $dest/bin/erb-formatter <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("erb-formatter", "erb-formatter", "0.7.3")
    BINSTUB
        chmod +x $dest/bin/erb-formatter
  '';
}
