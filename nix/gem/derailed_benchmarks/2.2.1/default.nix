#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# derailed_benchmarks 2.2.1
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
  pname = "derailed_benchmarks";
  version = "2.2.1";
  src = builtins.path {
    path = ./source;
    name = "derailed_benchmarks-2.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/derailed_benchmarks-2.2.1
        cp -r . $dest/gems/derailed_benchmarks-2.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/derailed_benchmarks-2.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "derailed_benchmarks"
      s.version = "2.2.1"
      s.summary = "derailed_benchmarks"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["derailed"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/derailed <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("derailed_benchmarks", "derailed", "2.2.1")
    BINSTUB
        chmod +x $dest/bin/derailed
  '';
}
