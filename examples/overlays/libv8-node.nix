# libv8-node: provide V8 headers + static lib from nixpkgs nodejs
#
# The gem normally downloads and compiles Node.js from source to get V8.
# We skip that entirely and symlink nixpkgs' nodejs_24.libv8 into the
# vendor/ layout the gem expects. This is the gem's own interface —
# Libv8::Node::Paths reads from vendor/v8/.
#
# Layout created:
#   vendor/v8/include/          → nodejs.libv8 headers (v8.h etc.)
#   vendor/v8/<platform>/libv8/obj/libv8_monolith.a → nodejs.libv8 static lib
#   ext/libv8-node/.location.yml → tells Location.load! to use Vendor paths
#
# mini_racer then does: require 'libv8-node'; Libv8::Node.configure_makefile
# which reads these paths and sets $INCFLAGS / $LDFLAGS for its own build.
#
{ pkgs, ruby }:
let
  libv8 = pkgs.nodejs_24.libv8;
in
{
  deps = [ ];
  buildPhase = ''
    # Determine the platform string the gem uses (e.g. x86_64-linux)
    platform=$(ruby -e 'puts Gem::Platform.local.to_s.gsub(/-darwin-?\d+/, "-darwin")')

    # vendor/v8/include/ — V8 headers
    mkdir -p vendor/v8/include
    ln -sf ${libv8}/include/* vendor/v8/include/

    # vendor/v8/<platform>/libv8/obj/libv8_monolith.a — static V8 library
    # nixpkgs calls it libv8.a, the gem expects libv8_monolith.a
    mkdir -p "vendor/v8/$platform/libv8/obj"
    ln -s ${libv8}/lib/libv8.a "vendor/v8/$platform/libv8/obj/libv8_monolith.a"

    # .location.yml — read by Location.load! to select the Vendor code path
    # (the gem writes this itself during normal install; we provide it directly)
    cat > ext/libv8-node/.location.yml <<YAML
    --- !ruby/object:Libv8::Node::Location::Vendor {}
    YAML
  '';
}
