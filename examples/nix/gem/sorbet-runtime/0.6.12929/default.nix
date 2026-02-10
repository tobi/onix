#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sorbet-runtime 0.6.12929
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
  pname = "sorbet-runtime";
  version = "0.6.12929";
  src = builtins.path {
    path = ./source;
    name = "sorbet-runtime-0.6.12929-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sorbet-runtime-0.6.12929
        cp -r . $dest/gems/sorbet-runtime-0.6.12929/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sorbet-runtime-0.6.12929.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sorbet-runtime"
      s.version = "0.6.12929"
      s.summary = "sorbet-runtime"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
