#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-rc4 0.1.5
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
  pname = "ruby-rc4";
  version = "0.1.5";
  src = builtins.path {
    path = ./source;
    name = "ruby-rc4-0.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-rc4-0.1.5
        cp -r . $dest/gems/ruby-rc4-0.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-rc4-0.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-rc4"
      s.version = "0.1.5"
      s.summary = "ruby-rc4"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
