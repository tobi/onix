#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-smtp 0.3.4
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
  pname = "net-smtp";
  version = "0.3.4";
  src = builtins.path {
    path = ./source;
    name = "net-smtp-0.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-smtp-0.3.4
        cp -r . $dest/gems/net-smtp-0.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-smtp-0.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-smtp"
      s.version = "0.3.4"
      s.summary = "net-smtp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
