#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_dev_assets 0.0.6
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
  pname = "discourse_dev_assets";
  version = "0.0.6";
  src = builtins.path {
    path = ./source;
    name = "discourse_dev_assets-0.0.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/discourse_dev_assets-0.0.6
        cp -r . $dest/gems/discourse_dev_assets-0.0.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse_dev_assets-0.0.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse_dev_assets"
      s.version = "0.0.6"
      s.summary = "discourse_dev_assets"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
