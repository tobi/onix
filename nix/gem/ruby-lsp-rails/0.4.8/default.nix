#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rails 0.4.8
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "ruby-lsp-rails";
  version = "0.4.8";
  src = builtins.path {
    path = ./source;
    name = "ruby-lsp-rails-0.4.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/ruby-lsp-rails-0.4.8
        cp -r . $dest/gems/ruby-lsp-rails-0.4.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-lsp-rails-0.4.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-lsp-rails"
      s.version = "0.4.8"
      s.summary = "ruby-lsp-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
