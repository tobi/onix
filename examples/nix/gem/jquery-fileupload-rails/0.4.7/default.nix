#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-fileupload-rails 0.4.7
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
  pname = "jquery-fileupload-rails";
  version = "0.4.7";
  src = builtins.path {
    path = ./source;
    name = "jquery-fileupload-rails-0.4.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jquery-fileupload-rails-0.4.7
        cp -r . $dest/gems/jquery-fileupload-rails-0.4.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jquery-fileupload-rails-0.4.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jquery-fileupload-rails"
      s.version = "0.4.7"
      s.summary = "jquery-fileupload-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
