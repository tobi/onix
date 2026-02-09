#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-next-core 0.15.2
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
  pname = "ruby-next-core";
  version = "0.15.2";
  src = builtins.path {
    path = ./source;
    name = "ruby-next-core-0.15.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-next-core-0.15.2
        cp -r . $dest/gems/ruby-next-core-0.15.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-next-core-0.15.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-next-core"
      s.version = "0.15.2"
      s.summary = "ruby-next-core"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ruby-next"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ruby-next <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-next-core", "ruby-next", "0.15.2")
    BINSTUB
        chmod +x $dest/bin/ruby-next
  '';
}
