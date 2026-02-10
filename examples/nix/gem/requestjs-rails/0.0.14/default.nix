#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# requestjs-rails 0.0.14
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
  pname = "requestjs-rails";
  version = "0.0.14";
  src = builtins.path {
    path = ./source;
    name = "requestjs-rails-0.0.14-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/requestjs-rails-0.0.14
        cp -r . $dest/gems/requestjs-rails-0.0.14/
        mkdir -p $dest/specifications
        cat > $dest/specifications/requestjs-rails-0.0.14.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "requestjs-rails"
      s.version = "0.0.14"
      s.summary = "requestjs-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
