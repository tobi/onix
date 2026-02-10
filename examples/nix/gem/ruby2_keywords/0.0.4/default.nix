#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby2_keywords 0.0.4
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
  version = "0.0.4";
  src = builtins.path {
    path = ./source;
    name = "ruby2_keywords-0.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby2_keywords-0.0.4
        cp -r . $dest/gems/ruby2_keywords-0.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby2_keywords-0.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby2_keywords"
      s.version = "0.0.4"
      s.summary = "ruby2_keywords"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
