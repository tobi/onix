# frozen_string_literal: true

module Gemset2Nix
  module Commands
    class Init
      def run(argv)
        root = argv.shift || "."
        root = File.expand_path(root)

        dirs = %w[
          cache/sources cache/meta cache/gems cache/git-clones
          nix/gem nix/app nix/modules
          overlays imports
        ]

        dirs.each do |d|
          path = File.join(root, d)
          FileUtils.mkdir_p(path)
          $stderr.puts "  create #{d}/"
        end

        # .gitignore for cache
        gitignore = File.join(root, "cache", ".gitignore")
        unless File.exist?(gitignore)
          File.write(gitignore, "gems/\ngit-clones/\n")
          $stderr.puts "  create cache/.gitignore"
        end

        # resolve.nix — the module system entry point
        resolve = File.join(root, "nix", "modules", "resolve.nix")
        unless File.exist?(resolve)
          File.write(resolve, RESOLVE_NIX)
          $stderr.puts "  create nix/modules/resolve.nix"
        end

        # empty apps registry
        apps = File.join(root, "nix", "modules", "apps.nix")
        unless File.exist?(apps)
          File.write(apps, "{\n}\n")
          $stderr.puts "  create nix/modules/apps.nix"
        end

        $stderr.puts "Done. Next steps:"
        $stderr.puts "  gemset2nix import myapp path/to/Gemfile.lock"
        $stderr.puts "  gemset2nix fetch"
        $stderr.puts "  gemset2nix update"
        $stderr.puts "  gemset2nix build"
      end

      RESOLVE_NIX = <<~'NIX'
        #
        # resolve.nix — turn a gemset (list or module-style config) into built derivations.
        #
        # Usage:
        #   resolve { inherit pkgs ruby; gemset = import ../app/fizzy.nix; }
        #   resolve { inherit pkgs ruby; gemset = { gem.app.fizzy.enable = true; }; }
        #
        {
          pkgs,
          ruby,
          gemset,
        }:
        let
          inherit (pkgs) lib stdenv;
          gems = import ./gem.nix { inherit pkgs ruby; };
          apps = import ./apps.nix;

          # Normalise: attrset (module-style) or list (legacy)
          isList = builtins.isList gemset;
          isModule = builtins.isAttrs gemset && gemset ? gem;

          # Module-style: collect enabled app gem lists + per-gem overrides
          moduleGems =
            if isModule then
              let
                appCfg = gemset.gem.app or { };
                enabledApps = lib.filterAttrs (_: v: v.enable or false) appCfg;
                appGemLists = lib.mapAttrsToList (
                  name: _:
                  if apps ? ${name} then
                    apps.${name}
                  else
                    throw "gem.app.${name}: unknown app. Available: ${builtins.concatStringsSep ", " (builtins.attrNames apps)}"
                ) enabledApps;
              in
              lib.concatLists appGemLists
            else
              [ ];

          specs = if isList then gemset else moduleGems;

          build =
            spec:
            let
              args = builtins.removeAttrs spec [ "name" ];
            in
            {
              name = spec.name;
              value = gems.${spec.name} args;
            };
        in
        builtins.listToAttrs (map build specs)
      NIX
    end
  end
end
