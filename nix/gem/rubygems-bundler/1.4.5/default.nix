#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubygems-bundler 1.4.5
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
  pname = "rubygems-bundler";
  version = "1.4.5";
  src = builtins.path {
    path = ./source;
    name = "rubygems-bundler-1.4.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubygems-bundler-1.4.5
        cp -r . $dest/gems/rubygems-bundler-1.4.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubygems-bundler-1.4.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubygems-bundler"
      s.version = "1.4.5"
      s.summary = "rubygems-bundler"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
