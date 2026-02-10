#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-imap 0.4.10
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
  pname = "net-imap";
  version = "0.4.10";
  src = builtins.path {
    path = ./source;
    name = "net-imap-0.4.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-imap-0.4.10
        cp -r . $dest/gems/net-imap-0.4.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-imap-0.4.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-imap"
      s.version = "0.4.10"
      s.summary = "net-imap"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
