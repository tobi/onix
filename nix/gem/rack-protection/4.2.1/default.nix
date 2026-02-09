#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-protection 4.2.1
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
  pname = "rack-protection";
  version = "4.2.1";
  src = builtins.path {
    path = ./source;
    name = "rack-protection-4.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rack-protection-4.2.1
        cp -r . $dest/gems/rack-protection-4.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-protection-4.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-protection"
      s.version = "4.2.1"
      s.summary = "rack-protection"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
