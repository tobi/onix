# hiredis (ruby gem) — vendor/hiredis code is broken on modern GCC or missing.
# Replace with system hiredis library.
{ pkgs, ruby, ... }:
let
  hiredis-c = pkgs.hiredis;
in
{
  deps = [ hiredis-c ];
  buildPhase = ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")

      # Replace vendor/hiredis with system lib so the gem doesn't try to compile it
      rm -rf vendor/hiredis
      mkdir -p vendor/hiredis
      # Copy all headers (including subdir structure)
      cp -r ${hiredis-c}/include/hiredis/* vendor/hiredis/
      # Copy static lib
      cp ${hiredis-c}/lib/libhiredis.a vendor/hiredis/

      # Patch extconf.rb to skip the `make static` step in vendor/hiredis
      sed -i '/Dir\.chdir(hiredis_dir)/,/end/{ s/system.*make.*/# patched out/; }' "$dir/extconf.rb"
      # Also handle the simpler inline check
      sed -i 's/success = system.*make.*/success = true/' "$dir/extconf.rb"

      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES) || true
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
