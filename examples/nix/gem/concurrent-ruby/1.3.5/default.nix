#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# concurrent-ruby 1.3.5
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
  pname = "concurrent-ruby";
  version = "1.3.5";
  src = builtins.path {
    path = ./source;
    name = "concurrent-ruby-1.3.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/concurrent-ruby-1.3.5
        cp -r . $dest/gems/concurrent-ruby-1.3.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/concurrent-ruby-1.3.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "concurrent-ruby"
      s.version = "1.3.5"
      s.summary = "concurrent-ruby"
      s.require_paths = ["lib/concurrent-ruby"]
      s.files = []
    end
    EOF
  '';
}
