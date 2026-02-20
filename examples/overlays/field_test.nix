# field_test — C++ extension via Rice (mkmf-rice)
{
  pkgs,
  ruby,
  buildGem,
  ...
}:
{
  buildGems = [
    (buildGem "rice")
  ];
}
