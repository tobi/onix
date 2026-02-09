#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# request_store 1.7.0
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
  pname = "request_store";
  version = "1.7.0";
  src = builtins.path {
    path = ./source;
    name = "request_store-1.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/request_store-1.7.0
        cp -r . $dest/gems/request_store-1.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/request_store-1.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "request_store"
      s.version = "1.7.0"
      s.summary = "request_store"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
