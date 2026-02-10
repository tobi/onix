# mini_racer — Links against libv8-node's pre-built libv8_monolith.a
# which was compiled without -fPIC, causing relocation errors on NixOS.
# This requires rebuilding V8 from source or using a platform-specific gem.
# Skip the build for now.
{ pkgs, ruby }:
{
  deps = [ ];
  buildPhase = ''
    echo "mini_racer: skipping build (libv8_monolith.a relocation error)"
  '';
}
