#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-api-client 0.52.0
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
  pname = "google-api-client";
  version = "0.52.0";
  src = builtins.path {
    path = ./source;
    name = "google-api-client-0.52.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-api-client-0.52.0
        cp -r . $dest/gems/google-api-client-0.52.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-api-client-0.52.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-api-client"
      s.version = "0.52.0"
      s.summary = "google-api-client"
      s.require_paths = ["lib", "generated"]
      s.bindir = "bin"
      s.executables = ["generate-api"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/generate-api <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("google-api-client", "generate-api", "0.52.0")
    BINSTUB
        chmod +x $dest/bin/generate-api
  '';
}
