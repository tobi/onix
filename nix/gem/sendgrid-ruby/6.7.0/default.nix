#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sendgrid-ruby 6.7.0
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
  version = "6.7.0";
  src = builtins.path {
    path = ./source;
    name = "sendgrid-ruby-6.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sendgrid-ruby-6.7.0
        cp -r . $dest/gems/sendgrid-ruby-6.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sendgrid-ruby-6.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sendgrid-ruby"
      s.version = "6.7.0"
      s.summary = "sendgrid-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
