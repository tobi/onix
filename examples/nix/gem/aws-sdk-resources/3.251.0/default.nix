#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-resources 3.251.0
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
  pname = "aws-sdk-resources";
  version = "3.251.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-resources-3.251.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-resources-3.251.0
        cp -r . $dest/gems/aws-sdk-resources-3.251.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-resources-3.251.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-resources"
      s.version = "3.251.0"
      s.summary = "aws-sdk-resources"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["aws-v3.rb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/aws-v3.rb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("aws-sdk-resources", "aws-v3.rb", "3.251.0")
    BINSTUB
        chmod +x $dest/bin/aws-v3.rb
  '';
}
