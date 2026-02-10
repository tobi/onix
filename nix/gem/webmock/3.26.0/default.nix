#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webmock 3.26.0
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
  pname = "webmock";
  version = "3.26.0";
  src = builtins.path {
    path = ./source;
    name = "webmock-3.26.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webmock-3.26.0
        cp -r . $dest/gems/webmock-3.26.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webmock-3.26.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webmock"
      s.version = "3.26.0"
      s.summary = "webmock"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
