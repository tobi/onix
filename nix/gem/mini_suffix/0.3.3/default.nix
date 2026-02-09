#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_suffix 0.3.3
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
  pname = "mini_suffix";
  version = "0.3.3";
  src = builtins.path {
    path = ./source;
    name = "mini_suffix-0.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/mini_suffix-0.3.3
        cp -r . $dest/gems/mini_suffix-0.3.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_suffix-0.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_suffix"
      s.version = "0.3.3"
      s.summary = "mini_suffix"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
