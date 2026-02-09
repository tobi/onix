# field_test — needs rice gem (mkmf-rice) at build time
{ pkgs, ruby }:
let
  rice = pkgs.callPackage ../nix/gem/rice/4.1.0 { inherit ruby; };
in
{
  deps = [ ];
  beforeBuild = ''
    export GEM_PATH=${rice}/${rice.bundle_path}
  '';
}
