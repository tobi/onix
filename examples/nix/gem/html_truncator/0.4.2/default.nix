#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# html_truncator 0.4.2
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
  pname = "html_truncator";
  version = "0.4.2";
  src = builtins.path {
    path = ./source;
    name = "html_truncator-0.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/html_truncator-0.4.2
        cp -r . $dest/gems/html_truncator-0.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/html_truncator-0.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "html_truncator"
      s.version = "0.4.2"
      s.summary = "html_truncator"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
