#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# squasher 0.7.2
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
  pname = "squasher";
  version = "0.7.2";
  src = builtins.path {
    path = ./source;
    name = "squasher-0.7.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/squasher-0.7.2
        cp -r . $dest/gems/squasher-0.7.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/squasher-0.7.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "squasher"
      s.version = "0.7.2"
      s.summary = "squasher"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["squasher"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/squasher <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("squasher", "squasher", "0.7.2")
    BINSTUB
        chmod +x $dest/bin/squasher
  '';
}
