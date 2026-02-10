{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_3 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.discourse.enable = true; }; };
in gems.devShell {
  name = "discourse-devshell";
  buildInputs = with pkgs; [
    (postgresql.withPackages (ps: [ ps.pgvector ]))
    redis nodejs_22
    vips imagemagick libyaml openssl zlib pkg-config libffi git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    rm -rf tmp/cache/bootsnap 2>/dev/null
  '';
}
