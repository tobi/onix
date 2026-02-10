# field_test — C++ extension via Rice (mkmf-rice)
{ pkgs, ruby }:
{
  buildGems = [
    (pkgs.callPackage ../nix/gem/rice/4.1.0 { inherit ruby; })
  ];
}
