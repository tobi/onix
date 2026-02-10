#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mdl 0.12.0
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
  pname = "mdl";
  version = "0.12.0";
  src = builtins.path {
    path = ./source;
    name = "mdl-0.12.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mdl-0.12.0
        cp -r . $dest/gems/mdl-0.12.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mdl-0.12.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mdl"
      s.version = "0.12.0"
      s.summary = "mdl"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["mdl"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/mdl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("mdl", "mdl", "0.12.0")
    BINSTUB
        chmod +x $dest/bin/mdl
  '';
}
