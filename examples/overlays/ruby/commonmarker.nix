# commonmarker — Rust extension via rb_sys, needs cargo/rustc + clang for bindgen
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [
    rustc
    cargo
    libclang
  ];
  buildGems = [
    (buildGem "rb_sys")
  ];
  buildPhase = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"

    # Pin crates that require newer rustc than nixpkgs provides
    for d in $(find ext -name Cargo.toml -not -path '*/target/*'); do
      dir=$(dirname "$d")
      echo "Generating lockfile in $dir..."
      (cd "$dir" && cargo generate-lockfile)
      echo "Pinning darling and time crates for rustc compatibility..."
      (cd "$dir" && cargo update darling --precise 0.20.10 2>&1 || true)
      (cd "$dir" && cargo update darling_core --precise 0.20.10 2>&1 || true)
      (cd "$dir" && cargo update darling_macro --precise 0.20.10 2>&1 || true)
      (cd "$dir" && cargo update time --precise 0.3.36 2>&1 || true)
      (cd "$dir" && cargo update time-core --precise 0.1.2 2>&1 || true)
      echo "Lockfile ready."
    done

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
      fi
    done
  '';
}
