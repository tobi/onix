# Forem dev/test shell — PostgreSQL + Redis via local tmpdir services.
#
# Usage:
#   cd ~/src/ruby-tests/forem && nix-shell ../../tries/2026-02-07-scint/gemset2nix/tests/forem/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_3
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.forem.enable = true; }; };
  bundlePath = pkgs.buildEnv {
    name = "forem-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "forem-devshell";

  buildInputs = [
    ruby
    (pkgs.postgresql.withPackages (ps: [ ps.pgvector ]))
    pkgs.redis
    pkgs.nodejs_22
    pkgs.yarn
    pkgs.vips
    pkgs.imagemagick
    pkgs.libyaml
    pkgs.openssl
    pkgs.zlib
    pkgs.pkg-config
    pkgs.libffi
    pkgs.git
  ];

  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    export PGDATA="$TMPDIR/pg"
    export PGHOST="$TMPDIR/pg"
    export PGPORT="5433"
    export REDIS_URL="redis://localhost:6380"

    if [ ! -d "$PGDATA" ]; then
      initdb --no-locale -D "$PGDATA" -U postgres >/dev/null 2>&1
      echo "unix_socket_directories = '$PGDATA'" >> "$PGDATA/postgresql.conf"
      echo "port = $PGPORT" >> "$PGDATA/postgresql.conf"
    fi
    pg_ctl -D "$PGDATA" -l "$TMPDIR/pg.log" -o "-k $PGDATA" -w start >/dev/null 2>&1 || true
    redis-server --daemonize yes --port 6380 --dir "$TMPDIR" --logfile "$TMPDIR/redis.log" >/dev/null 2>&1 || true

    export DATABASE_URL="postgres://postgres@localhost:$PGPORT/forem_test"
    export RAILS_ENV="test"

    rm -rf tmp/cache/bootsnap 2>/dev/null

    echo "forem devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.3.0/gems 2>/dev/null | wc -l)"
  '';
}
