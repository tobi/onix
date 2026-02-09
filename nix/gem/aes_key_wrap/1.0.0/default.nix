#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aes_key_wrap 1.0.0
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
  pname = "aes_key_wrap";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "aes_key_wrap-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aes_key_wrap-1.0.0
        cp -r . $dest/gems/aes_key_wrap-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aes_key_wrap-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aes_key_wrap"
      s.version = "1.0.0"
      s.summary = "aes_key_wrap"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
