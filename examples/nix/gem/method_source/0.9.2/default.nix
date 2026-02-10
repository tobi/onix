#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# method_source 0.9.2
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
  pname = "method_source";
  version = "0.9.2";
  src = builtins.path {
    path = ./source;
    name = "method_source-0.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/method_source-0.9.2
        cp -r . $dest/gems/method_source-0.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/method_source-0.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "method_source"
      s.version = "0.9.2"
      s.summary = "method_source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
