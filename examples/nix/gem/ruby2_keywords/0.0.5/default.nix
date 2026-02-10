#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby2_keywords 0.0.5
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
  pname = "ruby2_keywords";
  version = "0.0.5";
  src = builtins.path {
    path = ./source;
    name = "ruby2_keywords-0.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby2_keywords-0.0.5
        cp -r . $dest/gems/ruby2_keywords-0.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby2_keywords-0.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby2_keywords"
      s.version = "0.0.5"
      s.summary = "ruby2_keywords"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
