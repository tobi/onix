#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_dep 1.5.0
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
  pname = "ruby_dep";
  version = "1.5.0";
  src = builtins.path {
    path = ./source;
    name = "ruby_dep-1.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby_dep-1.5.0
        cp -r . $dest/gems/ruby_dep-1.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby_dep-1.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby_dep"
      s.version = "1.5.0"
      s.summary = "ruby_dep"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
