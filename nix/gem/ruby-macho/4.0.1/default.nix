#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-macho 4.0.1
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
  pname = "ruby-macho";
  version = "4.0.1";
  src = builtins.path {
    path = ./source;
    name = "ruby-macho-4.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-macho-4.0.1
        cp -r . $dest/gems/ruby-macho-4.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-macho-4.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-macho"
      s.version = "4.0.1"
      s.summary = "ruby-macho"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
