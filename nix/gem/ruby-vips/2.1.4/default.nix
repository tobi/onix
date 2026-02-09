#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-vips 2.1.4
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
  pname = "ruby-vips";
  version = "2.1.4";
  src = builtins.path {
    path = ./source;
    name = "ruby-vips-2.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/ruby-vips-2.1.4
        cp -r . $dest/gems/ruby-vips-2.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-vips-2.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-vips"
      s.version = "2.1.4"
      s.summary = "ruby-vips"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
