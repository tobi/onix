#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# delayed_job 4.1.12
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
  pname = "delayed_job";
  version = "4.1.12";
  src = builtins.path {
    path = ./source;
    name = "delayed_job-4.1.12-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/delayed_job-4.1.12
        cp -r . $dest/gems/delayed_job-4.1.12/
        mkdir -p $dest/specifications
        cat > $dest/specifications/delayed_job-4.1.12.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "delayed_job"
      s.version = "4.1.12"
      s.summary = "delayed_job"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
