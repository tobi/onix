#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicorn 6.1.0
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
  pname = "unicorn";
  version = "6.1.0";
  src = builtins.path {
    path = ./source;
    name = "unicorn-6.1.0-source";
  };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
    done
    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
        mkdir -p "lib$target_prefix"
        cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
        echo "Installed $dir/$target_name.so -> lib$target_prefix/$target_name.so"
      fi
    done
  '';

  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/unicorn-6.1.0
        cp -r . $dest/gems/unicorn-6.1.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/unicorn-6.1.0
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s unicorn-6.1.0 $dest/gems/unicorn-6.1.0-$gp
        ln -s unicorn-6.1.0 $dest/extensions/${arch}/${rubyVersion}/unicorn-6.1.0-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/unicorn-6.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "unicorn"
      s.version = "6.1.0"
      s.summary = "unicorn"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["unicorn", "unicorn_rails"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/unicorn-6.1.0-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "unicorn"
      s.version = "6.1.0"
      s.platform = "$gp"
      s.summary = "unicorn"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["unicorn", "unicorn_rails"]
      s.files = []
    end
    PLATSPEC
        mkdir -p $dest/bin
        cat > $dest/bin/unicorn <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("unicorn", "unicorn", "6.1.0")
    BINSTUB
        chmod +x $dest/bin/unicorn
        cat > $dest/bin/unicorn_rails <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("unicorn", "unicorn_rails", "6.1.0")
    BINSTUB
        chmod +x $dest/bin/unicorn_rails
  '';
}
