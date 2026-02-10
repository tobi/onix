#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
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
  bundle_path = "ruby/${rubyVersion}";
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
    extconfFlags=""
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
    done
    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      for ext in so bundle; do
        if [ -n "$target_name" ] && [ -f "$dir/$target_name.$ext" ]; then
          mkdir -p "lib$target_prefix"
          cp "$dir/$target_name.$ext" "lib$target_prefix/$target_name.$ext"
          echo "Installed $dir/$target_name.$ext -> lib$target_prefix/$target_name.$ext"
        fi
      done
    done
  '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/unicorn-6.1.0
        cp -r . $dest/gems/unicorn-6.1.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/unicorn-6.1.0
        mkdir -p $extdir
        find . \( -name '*.so' -o -name '*.bundle' \) -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local cpu="${stdenv.hostPlatform.parsed.cpu.name}"
        if [ "$cpu" = "aarch64" ]; then cpu="arm64"; fi
        local gp="$cpu-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s unicorn-6.1.0 $dest/gems/unicorn-6.1.0-$gp
        ln -s unicorn-6.1.0 $dest/extensions/${arch}/${rubyVersion}/unicorn-6.1.0-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf unicorn-6.1.0 $dest/gems/unicorn-6.1.0-universal-darwin
          ln -sf unicorn-6.1.0 $dest/extensions/${arch}/${rubyVersion}/unicorn-6.1.0-universal-darwin
        fi
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
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/unicorn-6.1.0-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "unicorn"
      s.version = "6.1.0"
      s.platform = "universal-darwin"
      s.summary = "unicorn"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["unicorn", "unicorn_rails"]
      s.files = []
    end
    UNISPEC
        fi
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
