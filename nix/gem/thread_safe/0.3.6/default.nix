#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thread_safe 0.3.6
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
  pname = "thread_safe";
  version = "0.3.6";
  src = builtins.path {
    path = ./source;
    name = "thread_safe-0.3.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/thread_safe-0.3.6
        cp -r . $dest/gems/thread_safe-0.3.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/thread_safe-0.3.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "thread_safe"
      s.version = "0.3.6"
      s.summary = "thread_safe"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
