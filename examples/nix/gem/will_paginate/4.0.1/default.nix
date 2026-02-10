#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# will_paginate 4.0.1
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
  pname = "will_paginate";
  version = "4.0.1";
  src = builtins.path {
    path = ./source;
    name = "will_paginate-4.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/will_paginate-4.0.1
        cp -r . $dest/gems/will_paginate-4.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/will_paginate-4.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "will_paginate"
      s.version = "4.0.1"
      s.summary = "will_paginate"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
