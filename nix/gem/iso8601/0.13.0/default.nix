#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso8601 0.13.0
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
  pname = "iso8601";
  version = "0.13.0";
  src = builtins.path {
    path = ./source;
    name = "iso8601-0.13.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/iso8601-0.13.0
        cp -r . $dest/gems/iso8601-0.13.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/iso8601-0.13.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "iso8601"
      s.version = "0.13.0"
      s.summary = "iso8601"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
