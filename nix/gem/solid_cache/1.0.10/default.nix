#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cache 1.0.10
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
  pname = "solid_cache";
  version = "1.0.10";
  src = builtins.path {
    path = ./source;
    name = "solid_cache-1.0.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/solid_cache-1.0.10
        cp -r . $dest/gems/solid_cache-1.0.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/solid_cache-1.0.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "solid_cache"
      s.version = "1.0.10"
      s.summary = "solid_cache"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
