#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# playwright-ruby-client 1.57.1
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
  pname = "playwright-ruby-client";
  version = "1.57.1";
  src = builtins.path {
    path = ./source;
    name = "playwright-ruby-client-1.57.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/playwright-ruby-client-1.57.1
        cp -r . $dest/gems/playwright-ruby-client-1.57.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/playwright-ruby-client-1.57.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "playwright-ruby-client"
      s.version = "1.57.1"
      s.summary = "playwright-ruby-client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
