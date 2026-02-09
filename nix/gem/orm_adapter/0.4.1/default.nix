#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# orm_adapter 0.4.1
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
  pname = "orm_adapter";
  version = "0.4.1";
  src = builtins.path {
    path = ./source;
    name = "orm_adapter-0.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/orm_adapter-0.4.1
        cp -r . $dest/gems/orm_adapter-0.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/orm_adapter-0.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "orm_adapter"
      s.version = "0.4.1"
      s.summary = "orm_adapter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
