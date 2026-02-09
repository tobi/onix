#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sshkey 3.0.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "sshkey";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "sshkey-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/sshkey-3.0.0
        cp -r . $dest/gems/sshkey-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sshkey-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sshkey"
      s.version = "3.0.0"
      s.summary = "sshkey"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
