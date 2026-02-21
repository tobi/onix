# h3 — Uber's H3 geospatial indexing library
# The gem bundles H3 source and builds via cmake in ext/h3/src/
{ pkgs, ruby, ... }:
{
  deps = with pkgs; [ cmake ];
  buildPhase = ''
    # Fix deprecated .clang-tidy key that causes build errors with newer clang
    if [ -f ext/h3/src/.clang-tidy ]; then
      sed -i.bak '/AnalyzeTemporaryDtors/d' ext/h3/src/.clang-tidy && rm -f ext/h3/src/.clang-tidy.bak
    fi

    cd ext/h3/src
    mkdir -p build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DENABLE_DOCS=OFF -DENABLE_LINTING=OFF
    make -j$NIX_BUILD_CORES
    cd ../../../..

    # The gem uses FFI to load the shared lib — copy it to lib/
    find ext/h3/src/build -name '*.dylib' -o -name '*.so' | while read lib; do
      cp "$lib" lib/
    done
  '';
}
