#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# event_stream_parser 1.0.0
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
  pname = "event_stream_parser";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "event_stream_parser-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/event_stream_parser-1.0.0
        cp -r . $dest/gems/event_stream_parser-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/event_stream_parser-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "event_stream_parser"
      s.version = "1.0.0"
      s.summary = "event_stream_parser"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
