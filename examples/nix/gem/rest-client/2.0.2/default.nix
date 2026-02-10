#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rest-client 2.0.2
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
  pname = "rest-client";
  version = "2.0.2";
  src = builtins.path {
    path = ./source;
    name = "rest-client-2.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rest-client-2.0.2
        cp -r . $dest/gems/rest-client-2.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rest-client-2.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rest-client"
      s.version = "2.0.2"
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
    load Gem.bin_path("rest-client", "restclient", "2.0.2")
    BINSTUB
        chmod +x $dest/bin/restclient
  '';
}
