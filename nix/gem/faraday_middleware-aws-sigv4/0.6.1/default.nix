#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday_middleware-aws-sigv4 0.6.1
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
  pname = "faraday_middleware-aws-sigv4";
  version = "0.6.1";
  src = builtins.path {
    path = ./source;
    name = "faraday_middleware-aws-sigv4-0.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday_middleware-aws-sigv4-0.6.1
        cp -r . $dest/gems/faraday_middleware-aws-sigv4-0.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday_middleware-aws-sigv4-0.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday_middleware-aws-sigv4"
      s.version = "0.6.1"
      s.summary = "faraday_middleware-aws-sigv4"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
