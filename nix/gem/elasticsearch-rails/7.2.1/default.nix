#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-rails 7.2.1
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
  pname = "elasticsearch-rails";
  version = "7.2.1";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-rails-7.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-rails-7.2.1
        cp -r . $dest/gems/elasticsearch-rails-7.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-rails-7.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-rails"
      s.version = "7.2.1"
      s.summary = "elasticsearch-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
