{ pkgs }:
{
  deps = [ pkgs.python3 ];
  preInstall = ''
    echo "deprecated key example" >&2
  '';
  pnpmInstallFlags = [ "--frozen-lockfile" ];
}
