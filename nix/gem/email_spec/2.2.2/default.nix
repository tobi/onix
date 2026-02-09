#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_spec 2.2.2
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
  pname = "email_spec";
  version = "2.2.2";
  src = builtins.path {
    path = ./source;
    name = "email_spec-2.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/email_spec-2.2.2
        cp -r . $dest/gems/email_spec-2.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/email_spec-2.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "email_spec"
      s.version = "2.2.2"
      s.summary = "email_spec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
