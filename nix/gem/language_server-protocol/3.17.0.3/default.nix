#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# language_server-protocol 3.17.0.3
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
  version = "3.17.0.3";
  src = builtins.path {
    path = ./source;
    name = "language_server-protocol-3.17.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/language_server-protocol-3.17.0.3
        cp -r . $dest/gems/language_server-protocol-3.17.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/language_server-protocol-3.17.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "language_server-protocol"
      s.version = "3.17.0.3"
      s.summary = "language_server-protocol"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
