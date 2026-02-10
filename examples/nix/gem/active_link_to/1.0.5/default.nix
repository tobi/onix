#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_link_to 1.0.5
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
  pname = "active_link_to";
  version = "1.0.5";
  src = builtins.path {
    path = ./source;
    name = "active_link_to-1.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/active_link_to-1.0.5
        cp -r . $dest/gems/active_link_to-1.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/active_link_to-1.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "active_link_to"
      s.version = "1.0.5"
      s.summary = "active_link_to"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
