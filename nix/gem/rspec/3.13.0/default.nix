#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec 3.13.0
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
  pname = "rspec";
  version = "3.13.0";
  src = builtins.path {
    path = ./source;
    name = "rspec-3.13.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-3.13.0
        cp -r . $dest/gems/rspec-3.13.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-3.13.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec"
      s.version = "3.13.0"
      s.summary = "rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
