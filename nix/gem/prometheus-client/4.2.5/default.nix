#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prometheus-client 4.2.5
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
  pname = "prometheus-client";
  version = "4.2.5";
  src = builtins.path {
    path = ./source;
    name = "prometheus-client-4.2.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/prometheus-client-4.2.5
        cp -r . $dest/gems/prometheus-client-4.2.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/prometheus-client-4.2.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "prometheus-client"
      s.version = "4.2.5"
      s.summary = "prometheus-client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
