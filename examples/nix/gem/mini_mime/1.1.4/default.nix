#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_mime 1.1.4
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
  pname = "mini_mime";
  version = "1.1.4";
  src = builtins.path {
    path = ./source;
    name = "mini_mime-1.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mini_mime-1.1.4
        cp -r . $dest/gems/mini_mime-1.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_mime-1.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_mime"
      s.version = "1.1.4"
      s.summary = "mini_mime"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
