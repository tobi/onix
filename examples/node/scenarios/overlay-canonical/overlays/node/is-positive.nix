{ pkgs }:
{
  deps = [ pkgs.python3 ];
  preBuild = ''
    echo "onix node overlay preBuild for is-positive" >&2
  '';
  postBuild = ''
    echo "onix node overlay postBuild for is-positive" >&2
  '';
  postInstall = ''
    echo "onix node overlay postInstall for is-positive" >&2
  '';
  installFlags = [ "--link-workspace-packages=false" ];
}
