#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate-field-active_storage 1.0.3
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
  pname = "administrate-field-active_storage";
  version = "1.0.3";
  src = builtins.path {
    path = ./source;
    name = "administrate-field-active_storage-1.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/administrate-field-active_storage-1.0.3
        cp -r . $dest/gems/administrate-field-active_storage-1.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/administrate-field-active_storage-1.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "administrate-field-active_storage"
      s.version = "1.0.3"
      s.summary = "administrate-field-active_storage"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
