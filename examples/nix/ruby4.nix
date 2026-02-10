#
# ruby4.nix — Ruby 4.0.1 (not yet in nixpkgs)
#
# Uses nixpkgs' mkRuby to build Ruby 4.0.1 with the same infrastructure
# as ruby_3_x. Remove this file once nixpkgs ships ruby_4_0.
#
{ pkgs }:
let
  rubyPkgs = pkgs.callPackage <nixpkgs/pkgs/development/interpreters/ruby> {
    inherit (pkgs.darwin) libunwind;
  };
in
rubyPkgs.mkRuby {
  version = rubyPkgs.mkRubyVersion "4" "0" "1" "";
  hash = "sha256-OSS+LQXbMPTjX4Wb8Ci+hfS33QFxQUL9gj5K9d4vr50=";
  cargoHash = "sha256-z7NwWc4TaR042hNx0xgRkh/BQEpEJtE53cfrN0qNiE0=";
}
