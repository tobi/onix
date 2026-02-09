#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kramdown 2.5.2
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
  pname = "kramdown";
  version = "2.5.2";
  src = builtins.path {
    path = ./source;
    name = "kramdown-2.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/kramdown-2.5.2
        cp -r . $dest/gems/kramdown-2.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/kramdown-2.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kramdown"
      s.version = "2.5.2"
      s.summary = "kramdown"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["kramdown"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/kramdown <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("kramdown", "kramdown", "2.5.2")
    BINSTUB
        chmod +x $dest/bin/kramdown
  '';
}
