{
  description = "Convert Ruby Gemfile.lock to hermetic Nix derivations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    scint = {
      url = "github:tobi/scint";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, scint }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ruby = pkgs.ruby;
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "onix";
            version = "0.5.0";
            src = ./.;

            nativeBuildInputs = [ pkgs.makeWrapper ];

            dontBuild = true;

            installPhase = ''
              mkdir -p $out/lib $out/exe
              cp -r lib/* $out/lib/
              cp -r ${scint}/lib/* $out/lib/
              cp exe/onix $out/exe/onix

              mkdir -p $out/bin
              makeWrapper ${ruby}/bin/ruby $out/bin/onix \
                --prefix RUBYLIB : "$out/lib" \
                --prefix PATH : "${pkgs.lib.makeBinPath [
                  ruby
                  pkgs.git
                  pkgs.nix-prefetch-git
                ]}" \
                --add-flags "$out/exe/onix"
            '';
          };
        }
      );
    };
}
