#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# action_text-trix 2.1.16
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
  pname = "action_text-trix";
  version = "2.1.16";
  src = builtins.path {
    path = ./source;
    name = "action_text-trix-2.1.16-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/action_text-trix-2.1.16
        cp -r . $dest/gems/action_text-trix-2.1.16/
        mkdir -p $dest/specifications
        cat > $dest/specifications/action_text-trix-2.1.16.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "action_text-trix"
      s.version = "2.1.16"
      s.summary = "action_text-trix"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
