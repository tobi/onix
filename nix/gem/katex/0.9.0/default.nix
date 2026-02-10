#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# katex 0.9.0
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
  pname = "katex";
  version = "0.9.0";
  src = builtins.path {
    path = ./source;
    name = "katex-0.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/katex-0.9.0
        cp -r . $dest/gems/katex-0.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/katex-0.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "katex"
      s.version = "0.9.0"
      s.summary = "katex"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
