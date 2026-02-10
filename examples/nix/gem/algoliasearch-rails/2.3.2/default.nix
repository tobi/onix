#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch-rails 2.3.2
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
  pname = "algoliasearch-rails";
  version = "2.3.2";
  src = builtins.path {
    path = ./source;
    name = "algoliasearch-rails-2.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/algoliasearch-rails-2.3.2
        cp -r . $dest/gems/algoliasearch-rails-2.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/algoliasearch-rails-2.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "algoliasearch-rails"
      s.version = "2.3.2"
      s.summary = "algoliasearch-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
