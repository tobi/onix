#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# language_server-protocol 3.17.0.5
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
  pname = "language_server-protocol";
  version = "3.17.0.5";
  src = builtins.path {
    path = ./source;
    name = "language_server-protocol-3.17.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/language_server-protocol-3.17.0.5
        cp -r . $dest/gems/language_server-protocol-3.17.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/language_server-protocol-3.17.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "language_server-protocol"
      s.version = "3.17.0.5"
      s.summary = "language_server-protocol"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
