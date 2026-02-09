#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-sqs 5.1.1
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
  pname = "logstash-output-sqs";
  version = "5.1.1";
  src = builtins.path {
    path = ./source;
    name = "logstash-output-sqs-5.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logstash-output-sqs-5.1.1
        cp -r . $dest/gems/logstash-output-sqs-5.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logstash-output-sqs-5.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logstash-output-sqs"
      s.version = "5.1.1"
      s.summary = "logstash-output-sqs"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
