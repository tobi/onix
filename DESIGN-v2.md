# scint-to-nix design v2
#
# Architecture: pre-built gem universe, projects pick from it
#
# 1. .gems files  — "name version" per line, one per project
#    - Generated from Gemfile.lock via `bin/lockfile-to-gems`
#    - Git sources: "name version git:uri@rev"
#
# 2. bin/fetch    — reads all .gems files from a directory,
#    unions them, fetches .gem files in parallel (gem fetch --platform ruby),
#    unpacks source, reads metadata. Also fetches recent versions
#    of each gem for update headroom.
#
# 3. bin/build-cache — for every gem in the cache, generates + builds
#    Nix derivations for both aarch64-darwin and x86_64-linux
#
# 4. Per-project  — just a thin default.nix that references the
#    pre-built cache by name+version
#
# Directory layout:
#   gems/                         — .gems files directory
#     fizzy.gems
#     chatwoot.gems
#     discourse.gems
#   cache/
#     gems/                       — fetched .gem files
#     sources/                    — unpacked source trees
#     meta/                       — gem metadata (JSON)
#   nix/
#     nokogiri/1.19.0/default.nix — per-gem derivation
#     rails/8.0.4/default.nix
#     ...
