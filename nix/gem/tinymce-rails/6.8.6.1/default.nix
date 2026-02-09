#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tinymce-rails 6.8.6.1
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
  pname = "tinymce-rails";
  version = "6.8.6.1";
  src = builtins.path {
    path = ./source;
    name = "tinymce-rails-6.8.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tinymce-rails-6.8.6.1
        cp -r . $dest/gems/tinymce-rails-6.8.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tinymce-rails-6.8.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tinymce-rails"
      s.version = "6.8.6.1"
      s.summary = "tinymce-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
