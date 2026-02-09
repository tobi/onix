{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  buildPhase = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.prefix}
    cd ext/nokogiri
    ruby extconf.rb --use-system-libraries
    make -j$NIX_BUILD_CORES
    cd ../..
    mkdir -p lib/nokogiri
    cp ext/nokogiri/nokogiri.so lib/nokogiri/
  '';
}
