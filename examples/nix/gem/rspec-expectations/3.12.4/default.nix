#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-expectations 3.12.4
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
  pname = "rspec-expectations";
  version = "3.12.4";
  src = builtins.path {
    path = ./source;
    name = "rspec-expectations-3.12.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-expectations-3.12.4
        cp -r . $dest/gems/rspec-expectations-3.12.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-expectations-3.12.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-expectations"
      s.version = "3.12.4"
      s.summary = "rspec-expectations"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
