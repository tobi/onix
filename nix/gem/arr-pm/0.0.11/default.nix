#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arr-pm 0.0.11
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
  pname = "arr-pm";
  version = "0.0.11";
  src = builtins.path {
    path = ./source;
    name = "arr-pm-0.0.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/arr-pm-0.0.11
        cp -r . $dest/gems/arr-pm-0.0.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/arr-pm-0.0.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "arr-pm"
      s.version = "0.0.11"
      s.summary = "arr-pm"
      s.require_paths = ["lib", "lib"]
      s.files = []
    end
    EOF
  '';
}
