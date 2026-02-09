#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-listen 3.0.7
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
  pname = "sass-listen";
  version = "3.0.7";
  src = builtins.path {
    path = ./source;
    name = "sass-listen-3.0.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sass-listen-3.0.7
        cp -r . $dest/gems/sass-listen-3.0.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sass-listen-3.0.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sass-listen"
      s.version = "3.0.7"
      s.summary = "sass-listen"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["listen"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/listen <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sass-listen", "listen", "3.0.7")
    BINSTUB
        chmod +x $dest/bin/listen
  '';
}
