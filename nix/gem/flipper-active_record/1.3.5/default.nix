#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-active_record 1.3.5
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
  version = "1.3.5";
  src = builtins.path {
    path = ./source;
    name = "flipper-active_record-1.3.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-active_record-1.3.5
        cp -r . $dest/gems/flipper-active_record-1.3.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-active_record-1.3.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper-active_record"
      s.version = "1.3.5"
      s.summary = "flipper-active_record"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
