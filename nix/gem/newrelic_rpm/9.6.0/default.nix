#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic_rpm 9.6.0
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
  pname = "newrelic_rpm";
  version = "9.6.0";
  src = builtins.path {
    path = ./source;
    name = "newrelic_rpm-9.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/newrelic_rpm-9.6.0
        cp -r . $dest/gems/newrelic_rpm-9.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/newrelic_rpm-9.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "newrelic_rpm"
      s.version = "9.6.0"
      s.summary = "newrelic_rpm"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["newrelic_cmd", "newrelic", "nrdebug"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/newrelic_cmd <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("newrelic_rpm", "newrelic_cmd", "9.6.0")
    BINSTUB
        chmod +x $dest/bin/newrelic_cmd
        cat > $dest/bin/newrelic <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("newrelic_rpm", "newrelic", "9.6.0")
    BINSTUB
        chmod +x $dest/bin/newrelic
        cat > $dest/bin/nrdebug <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("newrelic_rpm", "nrdebug", "9.6.0")
    BINSTUB
        chmod +x $dest/bin/nrdebug
  '';
}
