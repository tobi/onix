#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_http_client 3.5.4
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
  pname = "ruby_http_client";
  version = "3.5.4";
  src = builtins.path {
    path = ./source;
    name = "ruby_http_client-3.5.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby_http_client-3.5.4
        cp -r . $dest/gems/ruby_http_client-3.5.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby_http_client-3.5.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby_http_client"
      s.version = "3.5.4"
      s.summary = "ruby_http_client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
