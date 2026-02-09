#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pundit-matchers 1.9.0
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
  pname = "pundit-matchers";
  version = "1.9.0";
  src = builtins.path {
    path = ./source;
    name = "pundit-matchers-1.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pundit-matchers-1.9.0
        cp -r . $dest/gems/pundit-matchers-1.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pundit-matchers-1.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pundit-matchers"
      s.version = "1.9.0"
      s.summary = "pundit-matchers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
