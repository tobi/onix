#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# local_time 3.0.3
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
  pname = "local_time";
  version = "3.0.3";
  src = builtins.path {
    path = ./source;
    name = "local_time-3.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/local_time-3.0.3
        cp -r . $dest/gems/local_time-3.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/local_time-3.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "local_time"
      s.version = "3.0.3"
      s.summary = "local_time"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
