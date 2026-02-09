#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeout 0.4.4
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
  pname = "timeout";
  version = "0.4.4";
  src = builtins.path {
    path = ./source;
    name = "timeout-0.4.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/timeout-0.4.4
        cp -r . $dest/gems/timeout-0.4.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/timeout-0.4.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "timeout"
      s.version = "0.4.4"
      s.summary = "timeout"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
