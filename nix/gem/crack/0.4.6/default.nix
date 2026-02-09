#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# crack 0.4.6
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
  pname = "crack";
  version = "0.4.6";
  src = builtins.path {
    path = ./source;
    name = "crack-0.4.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/crack-0.4.6
        cp -r . $dest/gems/crack-0.4.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/crack-0.4.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "crack"
      s.version = "0.4.6"
      s.summary = "crack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
