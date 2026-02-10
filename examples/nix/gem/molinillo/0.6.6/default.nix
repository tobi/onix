#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# molinillo 0.6.6
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
  pname = "molinillo";
  version = "0.6.6";
  src = builtins.path {
    path = ./source;
    name = "molinillo-0.6.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/molinillo-0.6.6
        cp -r . $dest/gems/molinillo-0.6.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/molinillo-0.6.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "molinillo"
      s.version = "0.6.6"
      s.summary = "molinillo"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
