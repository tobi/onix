#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-support 3.13.7
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
  pname = "rspec-support";
  version = "3.13.7";
  src = builtins.path {
    path = ./source;
    name = "rspec-support-3.13.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-support-3.13.7
        cp -r . $dest/gems/rspec-support-3.13.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-support-3.13.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-support"
      s.version = "3.13.7"
      s.summary = "rspec-support"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
