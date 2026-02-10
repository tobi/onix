#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-ld 3.3.2
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
  pname = "json-ld";
  version = "3.3.2";
  src = builtins.path {
    path = ./source;
    name = "json-ld-3.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/json-ld-3.3.2
        cp -r . $dest/gems/json-ld-3.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/json-ld-3.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "json-ld"
      s.version = "3.3.2"
      s.summary = "json-ld"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["jsonld"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/jsonld <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("json-ld", "jsonld", "3.3.2")
    BINSTUB
        chmod +x $dest/bin/jsonld
  '';
}
