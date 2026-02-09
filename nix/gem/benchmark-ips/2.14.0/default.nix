#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# benchmark-ips 2.14.0
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
  pname = "benchmark-ips";
  version = "2.14.0";
  src = builtins.path {
    path = ./source;
    name = "benchmark-ips-2.14.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/benchmark-ips-2.14.0
        cp -r . $dest/gems/benchmark-ips-2.14.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/benchmark-ips-2.14.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "benchmark-ips"
      s.version = "2.14.0"
      s.summary = "benchmark-ips"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
