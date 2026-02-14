# overlays/better-sqlite3.nix — native SQLite3 binding for Node.js
{ pkgs, nodejs, ... }:
let inherit (pkgs) lib stdenv sqlite pkg-config python3 darwin;
in {
  deps = [ sqlite pkg-config python3 ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ darwin.cctools ];
  buildFlags = "--build-from-source";
}
