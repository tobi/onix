#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-active_support_cache_store 1.3.5
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
  pname = "flipper-active_support_cache_store";
  version = "1.3.5";
  src = builtins.path {
    path = ./source;
    name = "flipper-active_support_cache_store-1.3.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-active_support_cache_store-1.3.5
        cp -r . $dest/gems/flipper-active_support_cache_store-1.3.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-active_support_cache_store-1.3.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper-active_support_cache_store"
      s.version = "1.3.5"
      s.summary = "flipper-active_support_cache_store"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
