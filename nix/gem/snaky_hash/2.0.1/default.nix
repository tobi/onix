#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# snaky_hash 2.0.1
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
  pname = "snaky_hash";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "snaky_hash-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/snaky_hash-2.0.1
        cp -r . $dest/gems/snaky_hash-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/snaky_hash-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "snaky_hash"
      s.version = "2.0.1"
      s.summary = "snaky_hash"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
