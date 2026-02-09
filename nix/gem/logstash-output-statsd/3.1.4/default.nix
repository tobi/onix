#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-statsd 3.1.4
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
  pname = "logstash-output-statsd";
  version = "3.1.4";
  src = builtins.path {
    path = ./source;
    name = "logstash-output-statsd-3.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logstash-output-statsd-3.1.4
        cp -r . $dest/gems/logstash-output-statsd-3.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logstash-output-statsd-3.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logstash-output-statsd"
      s.version = "3.1.4"
      s.summary = "logstash-output-statsd"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
