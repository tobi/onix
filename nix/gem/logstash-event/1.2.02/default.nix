#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-event 1.2.02
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
  pname = "logstash-event";
  version = "1.2.02";
  src = builtins.path {
    path = ./source;
    name = "logstash-event-1.2.02-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logstash-event-1.2.02
        cp -r . $dest/gems/logstash-event-1.2.02/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logstash-event-1.2.02.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logstash-event"
      s.version = "1.2.02"
      s.summary = "logstash-event"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
