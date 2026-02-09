#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-ole 1.2.13.1
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
  pname = "ruby-ole";
  version = "1.2.13.1";
  src = builtins.path {
    path = ./source;
    name = "ruby-ole-1.2.13.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-ole-1.2.13.1
        cp -r . $dest/gems/ruby-ole-1.2.13.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-ole-1.2.13.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-ole"
      s.version = "1.2.13.1"
      s.summary = "ruby-ole"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["oletool"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/oletool <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-ole", "oletool", "1.2.13.1")
    BINSTUB
        chmod +x $dest/bin/oletool
  '';
}
