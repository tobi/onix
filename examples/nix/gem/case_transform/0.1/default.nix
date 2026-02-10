#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# case_transform 0.1
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
  pname = "case_transform";
  version = "0.1";
  src = builtins.path {
    path = ./source;
    name = "case_transform-0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/case_transform-0.1
        cp -r . $dest/gems/case_transform-0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/case_transform-0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "case_transform"
      s.version = "0.1"
      s.summary = "case_transform"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
