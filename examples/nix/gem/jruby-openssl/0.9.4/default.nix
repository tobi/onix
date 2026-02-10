#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jruby-openssl 0.9.4
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
  pname = "jruby-openssl";
  version = "0.9.4";
  src = builtins.path {
    path = ./source;
    name = "jruby-openssl-0.9.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jruby-openssl-0.9.4
        cp -r . $dest/gems/jruby-openssl-0.9.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jruby-openssl-0.9.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jruby-openssl"
      s.version = "0.9.4"
      s.summary = "jruby-openssl"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
