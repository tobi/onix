#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-sqs 5.1.2
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
  version = "5.1.2";
  src = builtins.path {
    path = ./source;
    name = "logstash-output-sqs-5.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logstash-output-sqs-5.1.2
        cp -r . $dest/gems/logstash-output-sqs-5.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logstash-output-sqs-5.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logstash-output-sqs"
      s.version = "5.1.2"
      s.summary = "logstash-output-sqs"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
