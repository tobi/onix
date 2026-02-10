#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sixarm_ruby_unaccent 1.2.2
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
  pname = "sixarm_ruby_unaccent";
  version = "1.2.2";
  src = builtins.path {
    path = ./source;
    name = "sixarm_ruby_unaccent-1.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sixarm_ruby_unaccent-1.2.2
        cp -r . $dest/gems/sixarm_ruby_unaccent-1.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sixarm_ruby_unaccent-1.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sixarm_ruby_unaccent"
      s.version = "1.2.2"
      s.summary = "sixarm_ruby_unaccent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
