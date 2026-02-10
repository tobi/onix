#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uri_template 0.5.3
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
  pname = "uri_template";
  version = "0.5.3";
  src = builtins.path {
    path = ./source;
    name = "uri_template-0.5.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/uri_template-0.5.3
        cp -r . $dest/gems/uri_template-0.5.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uri_template-0.5.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uri_template"
      s.version = "0.5.3"
      s.summary = "uri_template"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
