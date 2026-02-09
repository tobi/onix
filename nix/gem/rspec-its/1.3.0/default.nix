#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-its 1.3.0
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
  pname = "rspec-its";
  version = "1.3.0";
  src = builtins.path {
    path = ./source;
    name = "rspec-its-1.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-its-1.3.0
        cp -r . $dest/gems/rspec-its-1.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-its-1.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-its"
      s.version = "1.3.0"
      s.summary = "rspec-its"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
