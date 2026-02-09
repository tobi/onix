#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shoulda-matchers 5.3.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "shoulda-matchers";
  version = "5.3.0";
  src = builtins.path {
    path = ./source;
    name = "shoulda-matchers-5.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/shoulda-matchers-5.3.0
        cp -r . $dest/gems/shoulda-matchers-5.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/shoulda-matchers-5.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "shoulda-matchers"
      s.version = "5.3.0"
      s.summary = "shoulda-matchers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
