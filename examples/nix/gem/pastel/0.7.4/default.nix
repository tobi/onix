#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pastel 0.7.4
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
  pname = "pastel";
  version = "0.7.4";
  src = builtins.path {
    path = ./source;
    name = "pastel-0.7.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pastel-0.7.4
        cp -r . $dest/gems/pastel-0.7.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pastel-0.7.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pastel"
      s.version = "0.7.4"
      s.summary = "pastel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
