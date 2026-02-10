#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# claide-plugins 0.9.2
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
  pname = "claide-plugins";
  version = "0.9.2";
  src = builtins.path {
    path = ./source;
    name = "claide-plugins-0.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/claide-plugins-0.9.2
        cp -r . $dest/gems/claide-plugins-0.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/claide-plugins-0.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "claide-plugins"
      s.version = "0.9.2"
      s.summary = "claide-plugins"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
