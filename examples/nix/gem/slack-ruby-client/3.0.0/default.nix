#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slack-ruby-client 3.0.0
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
  pname = "slack-ruby-client";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "slack-ruby-client-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/slack-ruby-client-3.0.0
        cp -r . $dest/gems/slack-ruby-client-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/slack-ruby-client-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "slack-ruby-client"
      s.version = "3.0.0"
      s.summary = "slack-ruby-client"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["slack"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/slack <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("slack-ruby-client", "slack", "3.0.0")
    BINSTUB
        chmod +x $dest/bin/slack
  '';
}
