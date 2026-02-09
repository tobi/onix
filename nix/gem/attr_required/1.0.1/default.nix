#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# attr_required 1.0.1
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
  pname = "attr_required";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "attr_required-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/attr_required-1.0.1
        cp -r . $dest/gems/attr_required-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/attr_required-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "attr_required"
      s.version = "1.0.1"
      s.summary = "attr_required"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
