#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# acts-as-taggable-on 12.0.0
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
  pname = "acts-as-taggable-on";
  version = "12.0.0";
  src = builtins.path {
    path = ./source;
    name = "acts-as-taggable-on-12.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/acts-as-taggable-on-12.0.0
        cp -r . $dest/gems/acts-as-taggable-on-12.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/acts-as-taggable-on-12.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "acts-as-taggable-on"
      s.version = "12.0.0"
      s.summary = "acts-as-taggable-on"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
