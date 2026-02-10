#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sendgrid-ruby 6.6.1
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
  pname = "sendgrid-ruby";
  version = "6.6.1";
  src = builtins.path {
    path = ./source;
    name = "sendgrid-ruby-6.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sendgrid-ruby-6.6.1
        cp -r . $dest/gems/sendgrid-ruby-6.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sendgrid-ruby-6.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sendgrid-ruby"
      s.version = "6.6.1"
      s.summary = "sendgrid-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
