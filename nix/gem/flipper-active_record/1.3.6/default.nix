#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-active_record 1.3.6
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
  pname = "flipper-active_record";
  version = "1.3.6";
  src = builtins.path {
    path = ./source;
    name = "flipper-active_record-1.3.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-active_record-1.3.6
        cp -r . $dest/gems/flipper-active_record-1.3.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-active_record-1.3.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper-active_record"
      s.version = "1.3.6"
      s.summary = "flipper-active_record"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
