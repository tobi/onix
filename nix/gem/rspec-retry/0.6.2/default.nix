#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-retry 0.6.2
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
  pname = "rspec-retry";
  version = "0.6.2";
  src = builtins.path {
    path = ./source;
    name = "rspec-retry-0.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-retry-0.6.2
        cp -r . $dest/gems/rspec-retry-0.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-retry-0.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-retry"
      s.version = "0.6.2"
      s.summary = "rspec-retry"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
