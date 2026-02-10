#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-v1 1.65.0
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
  pname = "aws-sdk-v1";
  version = "1.65.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-v1-1.65.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-v1-1.65.0
        cp -r . $dest/gems/aws-sdk-v1-1.65.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-v1-1.65.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-v1"
      s.version = "1.65.0"
      s.summary = "aws-sdk-v1"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["aws-rb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/aws-rb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("aws-sdk-v1", "aws-rb", "1.65.0")
    BINSTUB
        chmod +x $dest/bin/aws-rb
  '';
}
