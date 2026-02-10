#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prometheus_exporter 2.3.1
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
  pname = "prometheus_exporter";
  version = "2.3.1";
  src = builtins.path {
    path = ./source;
    name = "prometheus_exporter-2.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/prometheus_exporter-2.3.1
        cp -r . $dest/gems/prometheus_exporter-2.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/prometheus_exporter-2.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "prometheus_exporter"
      s.version = "2.3.1"
      s.summary = "prometheus_exporter"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["prometheus_exporter"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/prometheus_exporter <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("prometheus_exporter", "prometheus_exporter", "2.3.1")
    BINSTUB
        chmod +x $dest/bin/prometheus_exporter
  '';
}
