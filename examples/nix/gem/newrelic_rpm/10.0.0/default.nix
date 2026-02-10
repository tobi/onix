#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic_rpm 10.0.0
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
  pname = "newrelic_rpm";
  version = "10.0.0";
  src = builtins.path {
    path = ./source;
    name = "newrelic_rpm-10.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/newrelic_rpm-10.0.0
        cp -r . $dest/gems/newrelic_rpm-10.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/newrelic_rpm-10.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "newrelic_rpm"
      s.version = "10.0.0"
      s.summary = "newrelic_rpm"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["newrelic_rpm", "nrdebug"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/newrelic_rpm <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("newrelic_rpm", "newrelic_rpm", "10.0.0")
    BINSTUB
        chmod +x $dest/bin/newrelic_rpm
        cat > $dest/bin/nrdebug <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("newrelic_rpm", "nrdebug", "10.0.0")
    BINSTUB
        chmod +x $dest/bin/nrdebug
  '';
}
