#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-sftp 3.0.0
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
  pname = "net-sftp";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "net-sftp-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-sftp-3.0.0
        cp -r . $dest/gems/net-sftp-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-sftp-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-sftp"
      s.version = "3.0.0"
      s.summary = "net-sftp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
