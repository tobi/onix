#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shoulda-matchers 7.0.1
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
  pname = "shoulda-matchers";
  version = "7.0.1";
  src = builtins.path {
    path = ./source;
    name = "shoulda-matchers-7.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/shoulda-matchers-7.0.1
        cp -r . $dest/gems/shoulda-matchers-7.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/shoulda-matchers-7.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "shoulda-matchers"
      s.version = "7.0.1"
      s.summary = "shoulda-matchers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
