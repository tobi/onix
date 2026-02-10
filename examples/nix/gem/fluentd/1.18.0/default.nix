#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluentd 1.18.0
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
  pname = "fluentd";
  version = "1.18.0";
  src = builtins.path {
    path = ./source;
    name = "fluentd-1.18.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluentd-1.18.0
        cp -r . $dest/gems/fluentd-1.18.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluentd-1.18.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluentd"
      s.version = "1.18.0"
      s.summary = "fluentd"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["fluent-binlog-reader", "fluent-ca-generate", "fluent-cap-ctl", "fluent-cat", "fluent-ctl", "fluent-debug", "fluent-gem", "fluent-plugin-config-format", "fluent-plugin-generate", "fluentd"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/fluent-binlog-reader <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-binlog-reader", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-binlog-reader
        cat > $dest/bin/fluent-ca-generate <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-ca-generate", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-ca-generate
        cat > $dest/bin/fluent-cap-ctl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-cap-ctl", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-cap-ctl
        cat > $dest/bin/fluent-cat <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-cat", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-cat
        cat > $dest/bin/fluent-ctl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-ctl", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-ctl
        cat > $dest/bin/fluent-debug <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-debug", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-debug
        cat > $dest/bin/fluent-gem <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-gem", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-gem
        cat > $dest/bin/fluent-plugin-config-format <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-plugin-config-format", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-plugin-config-format
        cat > $dest/bin/fluent-plugin-generate <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluent-plugin-generate", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluent-plugin-generate
        cat > $dest/bin/fluentd <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fluentd", "fluentd", "1.18.0")
    BINSTUB
        chmod +x $dest/bin/fluentd
  '';
}
