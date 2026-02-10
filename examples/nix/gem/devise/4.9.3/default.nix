#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise 4.9.3
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
  pname = "devise";
  version = "4.9.3";
  src = builtins.path {
    path = ./source;
    name = "devise-4.9.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/devise-4.9.3
        cp -r . $dest/gems/devise-4.9.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/devise-4.9.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "devise"
      s.version = "4.9.3"
      s.summary = "devise"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
