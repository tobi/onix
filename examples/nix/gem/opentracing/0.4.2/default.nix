#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentracing 0.4.2
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
  pname = "opentracing";
  version = "0.4.2";
  src = builtins.path {
    path = ./source;
    name = "opentracing-0.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentracing-0.4.2
        cp -r . $dest/gems/opentracing-0.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentracing-0.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentracing"
      s.version = "0.4.2"
      s.summary = "opentracing"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
