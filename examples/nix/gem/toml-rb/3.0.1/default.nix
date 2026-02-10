#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# toml-rb 3.0.1
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
  pname = "toml-rb";
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "toml-rb-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/toml-rb-3.0.1
        cp -r . $dest/gems/toml-rb-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/toml-rb-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "toml-rb"
      s.version = "3.0.1"
      s.summary = "toml-rb"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
