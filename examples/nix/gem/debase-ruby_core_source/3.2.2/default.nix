#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debase-ruby_core_source 3.2.2
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
  pname = "debase-ruby_core_source";
  version = "3.2.2";
  src = builtins.path {
    path = ./source;
    name = "debase-ruby_core_source-3.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/debase-ruby_core_source-3.2.2
        cp -r . $dest/gems/debase-ruby_core_source-3.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/debase-ruby_core_source-3.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "debase-ruby_core_source"
      s.version = "3.2.2"
      s.summary = "debase-ruby_core_source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
