#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uniform_notifier 1.17.0
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
  pname = "uniform_notifier";
  version = "1.17.0";
  src = builtins.path {
    path = ./source;
    name = "uniform_notifier-1.17.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/uniform_notifier-1.17.0
        cp -r . $dest/gems/uniform_notifier-1.17.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uniform_notifier-1.17.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uniform_notifier"
      s.version = "1.17.0"
      s.summary = "uniform_notifier"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
