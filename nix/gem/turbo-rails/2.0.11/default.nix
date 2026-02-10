#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbo-rails 2.0.11
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
  pname = "turbo-rails";
  version = "2.0.11";
  src = builtins.path {
    path = ./source;
    name = "turbo-rails-2.0.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/turbo-rails-2.0.11
        cp -r . $dest/gems/turbo-rails-2.0.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/turbo-rails-2.0.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "turbo-rails"
      s.version = "2.0.11"
      s.summary = "turbo-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
