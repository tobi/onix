#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mustache 1.0.5
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
  pname = "mustache";
  version = "1.0.5";
  src = builtins.path {
    path = ./source;
    name = "mustache-1.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mustache-1.0.5
        cp -r . $dest/gems/mustache-1.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mustache-1.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mustache"
      s.version = "1.0.5"
      s.summary = "mustache"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["mustache"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/mustache <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("mustache", "mustache", "1.0.5")
    BINSTUB
        chmod +x $dest/bin/mustache
  '';
}
