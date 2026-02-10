#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# et-orbi 1.2.11
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
  pname = "et-orbi";
  version = "1.2.11";
  src = builtins.path {
    path = ./source;
    name = "et-orbi-1.2.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/et-orbi-1.2.11
        cp -r . $dest/gems/et-orbi-1.2.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/et-orbi-1.2.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "et-orbi"
      s.version = "1.2.11"
      s.summary = "et-orbi"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
