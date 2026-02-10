#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webpacker 5.4.2
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
  pname = "webpacker";
  version = "5.4.2";
  src = builtins.path {
    path = ./source;
    name = "webpacker-5.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webpacker-5.4.2
        cp -r . $dest/gems/webpacker-5.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webpacker-5.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webpacker"
      s.version = "5.4.2"
      s.summary = "webpacker"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
