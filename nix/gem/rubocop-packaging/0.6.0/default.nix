#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-packaging 0.6.0
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
  pname = "rubocop-packaging";
  version = "0.6.0";
  src = builtins.path {
    path = ./source;
    name = "rubocop-packaging-0.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-packaging-0.6.0
        cp -r . $dest/gems/rubocop-packaging-0.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-packaging-0.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-packaging"
      s.version = "0.6.0"
      s.summary = "rubocop-packaging"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
