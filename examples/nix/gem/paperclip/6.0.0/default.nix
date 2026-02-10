#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# paperclip 6.0.0
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
  pname = "paperclip";
  version = "6.0.0";
  src = builtins.path {
    path = ./source;
    name = "paperclip-6.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/paperclip-6.0.0
        cp -r . $dest/gems/paperclip-6.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/paperclip-6.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "paperclip"
      s.version = "6.0.0"
      s.summary = "paperclip"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
