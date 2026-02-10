#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-rails 0.3.10
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
  pname = "pry-rails";
  version = "0.3.10";
  src = builtins.path {
    path = ./source;
    name = "pry-rails-0.3.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pry-rails-0.3.10
        cp -r . $dest/gems/pry-rails-0.3.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pry-rails-0.3.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pry-rails"
      s.version = "0.3.10"
      s.summary = "pry-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
