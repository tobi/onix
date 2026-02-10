# Design: Nix-native fetch approach

## Current approach
```
onix fetch    → downloads .gem files into cache/
onix generate → copies sources into nix/gem/<name>/<version>/source/
                uses builtins.path to reference local files
```

## Proposed approach
```
onix import   → reads Gemfile.lock, computes sha256 hashes for each gem
                writes nix/gems.nix (data: name, version, sha256, source, deps)
onix build    → nix fetches gems itself via fetchurl/fetchgit
                buildRubyGem handles unpack + build + install
```

## Key insight

Instead of one `default.nix` per gem per version, we have:
- **One generic `buildGem` function** that knows how to build any gem
- **One data file** (`gems.nix`) listing all gems with their hashes
- **Overlays** for gems that need special handling

The `buildGem` function uses `fetchurl` for rubygems sources and `fetchgit`
for git sources. Nix handles caching — once fetched, it's in the store forever.

## gems.nix format

```nix
{
  rack = {
    version = "3.2.4";
    source = {
      type = "gem";
      remotes = [ "https://rubygems.org" ];
      sha256 = "abc123...";
    };
  };
  nokogiri = {
    version = "1.19.0";
    source = {
      type = "gem";
      remotes = [ "https://rubygems.org" ];
      sha256 = "def456...";
    };
    dependencies = [ "racc" "mini_portile2" ];
  };
  rails = {
    version = "8.2.0.alpha";
    source = {
      type = "git";
      url = "https://github.com/rails/rails.git";
      rev = "abc123...";
      sha256 = "...";
    };
  };
}
```

This is essentially the same format as bundix generates.

## buildGem function

A single nix function that:
1. Fetches the source (fetchurl for .gem, fetchgit for git)
2. Unpacks it
3. Runs extconf.rb + make if extensions exist
4. Installs into BUNDLE_PATH layout

Overlays compose with this by providing extra nativeBuildInputs,
extconfFlags, beforeBuild hooks, etc.
