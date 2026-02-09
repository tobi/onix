#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dogstatsd-ruby 5.6.6
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
  pname = "dogstatsd-ruby";
  version = "5.6.6";
  src = builtins.path {
    path = ./source;
    name = "dogstatsd-ruby-5.6.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dogstatsd-ruby-5.6.6
        cp -r . $dest/gems/dogstatsd-ruby-5.6.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dogstatsd-ruby-5.6.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dogstatsd-ruby"
      s.version = "5.6.6"
      s.summary = "dogstatsd-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
