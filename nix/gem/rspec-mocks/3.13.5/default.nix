#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-mocks 3.13.5
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
  pname = "rspec-mocks";
  version = "3.13.5";
  src = builtins.path {
    path = ./source;
    name = "rspec-mocks-3.13.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-mocks-3.13.5
        cp -r . $dest/gems/rspec-mocks-3.13.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-mocks-3.13.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-mocks"
      s.version = "3.13.5"
      s.summary = "rspec-mocks"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
