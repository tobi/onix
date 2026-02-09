#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-discourse 3.13.3
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
  pname = "rubocop-discourse";
  version = "3.13.3";
  src = builtins.path {
    path = ./source;
    name = "rubocop-discourse-3.13.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rubocop-discourse-3.13.3
        cp -r . $dest/gems/rubocop-discourse-3.13.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-discourse-3.13.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-discourse"
      s.version = "3.13.3"
      s.summary = "rubocop-discourse"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
