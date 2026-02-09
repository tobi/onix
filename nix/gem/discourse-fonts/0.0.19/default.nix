#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-fonts 0.0.19
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
  pname = "discourse-fonts";
  version = "0.0.19";
  src = builtins.path {
    path = ./source;
    name = "discourse-fonts-0.0.19-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/discourse-fonts-0.0.19
        cp -r . $dest/gems/discourse-fonts-0.0.19/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse-fonts-0.0.19.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse-fonts"
      s.version = "0.0.19"
      s.summary = "discourse-fonts"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
