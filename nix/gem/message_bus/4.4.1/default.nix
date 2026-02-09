#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# message_bus 4.4.1
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
  pname = "message_bus";
  version = "4.4.1";
  src = builtins.path {
    path = ./source;
    name = "message_bus-4.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/message_bus-4.4.1
        cp -r . $dest/gems/message_bus-4.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/message_bus-4.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "message_bus"
      s.version = "4.4.1"
      s.summary = "message_bus"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
