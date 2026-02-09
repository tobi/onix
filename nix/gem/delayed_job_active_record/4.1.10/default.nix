#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# delayed_job_active_record 4.1.10
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
  pname = "delayed_job_active_record";
  version = "4.1.10";
  src = builtins.path {
    path = ./source;
    name = "delayed_job_active_record-4.1.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/delayed_job_active_record-4.1.10
        cp -r . $dest/gems/delayed_job_active_record-4.1.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/delayed_job_active_record-4.1.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "delayed_job_active_record"
      s.version = "4.1.10"
      s.summary = "delayed_job_active_record"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
