#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guard 2.18.1
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
  pname = "guard";
  version = "2.18.1";
  src = builtins.path {
    path = ./source;
    name = "guard-2.18.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/guard-2.18.1
        cp -r . $dest/gems/guard-2.18.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/guard-2.18.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "guard"
      s.version = "2.18.1"
      s.summary = "guard"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["guard", "_guard-core"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/guard <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("guard", "guard", "2.18.1")
    BINSTUB
        chmod +x $dest/bin/guard
        cat > $dest/bin/_guard-core <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("guard", "_guard-core", "2.18.1")
    BINSTUB
        chmod +x $dest/bin/_guard-core
  '';
}
