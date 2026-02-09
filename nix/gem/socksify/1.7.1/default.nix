#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# socksify 1.7.1
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
  pname = "socksify";
  version = "1.7.1";
  src = builtins.path {
    path = ./source;
    name = "socksify-1.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/socksify-1.7.1
        cp -r . $dest/gems/socksify-1.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/socksify-1.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "socksify"
      s.version = "1.7.1"
      s.summary = "socksify"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["socksify_ruby"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/socksify_ruby <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("socksify", "socksify_ruby", "1.7.1")
    BINSTUB
        chmod +x $dest/bin/socksify_ruby
  '';
}
