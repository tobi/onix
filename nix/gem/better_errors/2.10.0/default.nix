#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# better_errors 2.10.0
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
  pname = "better_errors";
  version = "2.10.0";
  src = builtins.path {
    path = ./source;
    name = "better_errors-2.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/better_errors-2.10.0
        cp -r . $dest/gems/better_errors-2.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/better_errors-2.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "better_errors"
      s.version = "2.10.0"
      s.summary = "better_errors"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
