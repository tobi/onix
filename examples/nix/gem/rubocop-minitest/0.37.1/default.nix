#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-minitest 0.37.1
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
  pname = "rubocop-minitest";
  version = "0.37.1";
  src = builtins.path {
    path = ./source;
    name = "rubocop-minitest-0.37.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-minitest-0.37.1
        cp -r . $dest/gems/rubocop-minitest-0.37.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-minitest-0.37.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-minitest"
      s.version = "0.37.1"
      s.summary = "rubocop-minitest"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
