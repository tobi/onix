#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# event_emitter 0.2.6
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
  pname = "event_emitter";
  version = "0.2.6";
  src = builtins.path {
    path = ./source;
    name = "event_emitter-0.2.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/event_emitter-0.2.6
        cp -r . $dest/gems/event_emitter-0.2.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/event_emitter-0.2.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "event_emitter"
      s.version = "0.2.6"
      s.summary = "event_emitter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
