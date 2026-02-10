#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selectize-rails 0.12.6
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
  pname = "selectize-rails";
  version = "0.12.6";
  src = builtins.path {
    path = ./source;
    name = "selectize-rails-0.12.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/selectize-rails-0.12.6
        cp -r . $dest/gems/selectize-rails-0.12.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/selectize-rails-0.12.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "selectize-rails"
      s.version = "0.12.6"
      s.summary = "selectize-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
