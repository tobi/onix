#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-cookie_jar 0.0.7
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
  pname = "faraday-cookie_jar";
  version = "0.0.7";
  src = builtins.path {
    path = ./source;
    name = "faraday-cookie_jar-0.0.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-cookie_jar-0.0.7
        cp -r . $dest/gems/faraday-cookie_jar-0.0.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-cookie_jar-0.0.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-cookie_jar"
      s.version = "0.0.7"
      s.summary = "faraday-cookie_jar"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
