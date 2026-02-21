{
  pkgs ? import <nixpkgs> { },
  ruby ? pkgs.ruby_3_4,
}:
let
  project = import ../../nix/rails.nix { inherit pkgs ruby; };
in
project.devShell {
  name = "rails-devshell";
  buildInputs = with pkgs; [
    sqlite
    postgresql
    vips
    imagemagick
    libyaml
    openssl
    zlib
    pkg-config
    libffi
    git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${
      pkgs.lib.makeLibraryPath [
        pkgs.vips
        pkgs.imagemagick
        pkgs.libffi
      ]
    }''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  '';
}
