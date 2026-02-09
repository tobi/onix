#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rest-client 2.1.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rest-client";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "rest-client-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rest-client-2.1.0
        cp -r . $dest/gems/rest-client-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rest-client-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rest-client"
      s.version = "2.1.0"
      s.summary = "rest-client"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["restclient"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/restclient <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rest-client", "restclient", "2.1.0")
    BINSTUB
        chmod +x $dest/bin/restclient
  '';
}
