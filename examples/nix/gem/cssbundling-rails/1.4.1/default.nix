#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cssbundling-rails 1.4.1
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
  pname = "cssbundling-rails";
  version = "1.4.1";
  src = builtins.path {
    path = ./source;
    name = "cssbundling-rails-1.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cssbundling-rails-1.4.1
        cp -r . $dest/gems/cssbundling-rails-1.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cssbundling-rails-1.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cssbundling-rails"
      s.version = "1.4.1"
      s.summary = "cssbundling-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
