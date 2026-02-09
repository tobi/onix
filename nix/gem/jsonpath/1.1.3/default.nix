#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonpath 1.1.3
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
  pname = "jsonpath";
  version = "1.1.3";
  src = builtins.path {
    path = ./source;
    name = "jsonpath-1.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jsonpath-1.1.3
        cp -r . $dest/gems/jsonpath-1.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jsonpath-1.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jsonpath"
      s.version = "1.1.3"
      s.summary = "jsonpath"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["jsonpath"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/jsonpath <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("jsonpath", "jsonpath", "1.1.3")
    BINSTUB
        chmod +x $dest/bin/jsonpath
  '';
}
