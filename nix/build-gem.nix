# build-gem.nix — wrapper around nixpkgs buildRubyGem
#
# Accepts onix's argument format and translates to buildRubyGem parameters.
# Provides backward compatibility with existing overlays while using the
# standard Ruby gem build infrastructure from nixpkgs.
#
# Any attrs not listed below (e.g. patches, meta, propagatedBuildInputs)
# are passed through to buildRubyGem unchanged.
#
# Usage:
#   buildGem = import ./build-gem.nix { inherit pkgs ruby; };
#   buildGem {
#     gemName = "nokogiri";
#     version = "1.19.0";
#     source = { type = "gem"; remotes = [ "https://rubygems.org" ]; sha256 = "..."; };
#   }

{ pkgs, ruby }:

let
  inherit (pkgs) lib;
  buildRubyGem = pkgs.buildRubyGem.override { inherit ruby; };
in

{
  source,
  skip ? false,
  subdir ? ".", # subdirectory within git repo (monorepo support)
  buildGems ? [ ],
  extconfFlags ? "",
  preBuild ? "",
  buildPhase ? null,
  platform ? null, # non-null for prebuilt-only gems (e.g. sorbet-static)
  requirePaths ? [ "lib" ],
  executables ? [ ],
  bindir ? "exe",
  ...
}@args:

let
  key = "${args.gemName}-${args.version}";
  rp = builtins.concatStringsSep ", " (map (p: ''"${p}"'') requirePaths);

  # For git sources with subdir, pre-extract the subdirectory
  gitSrc =
    if source.type == "git" then
      builtins.fetchGit {
        inherit (source) url rev;
        allRefs = true;
        submodules = source.fetchSubmodules or false;
      }
    else
      null;

  hasSubdir =
    source.type == "git"
    && subdir != "."
    && gitSrc != null
    && builtins.pathExists (gitSrc + "/${subdir}/lib");

  # Whether we need to unpack and modify source before building.
  # When true, dontBuild is false so the gem is unpacked, allowing
  # preBuild hooks to modify the source before gem build + gem install.
  needsUnpack = buildPhase != null || preBuild != "";

  # Combine preBuild and custom buildPhase content into preBuild hook.
  # Custom buildPhase from overlays (which manually ran extconf.rb + make)
  # is placed in preBuild since buildRubyGem's own buildPhase handles
  # gem build, and gem install handles extension compilation.
  preBuildHook = lib.concatStrings [
    (lib.optionalString (preBuild != "") preBuild)
    (lib.optionalString (buildPhase != null && preBuild != "") "\n")
    (lib.optionalString (buildPhase != null) buildPhase)
  ];

  # Attrs to strip before forwarding to buildRubyGem
  removedAttrs = [
    "source"
    "skip"
    "subdir"
    "buildGems"
    "extconfFlags"
    "preBuild"
    "buildPhase"
    "platform"
    "requirePaths"
    "executables"
    "bindir"
  ];

in
if skip then
  # Produce an empty derivation with a minimal gemspec
  pkgs.runCommand key { } ''
    mkdir -p $out/${ruby.gemPath}/gems/${key}
    mkdir -p $out/${ruby.gemPath}/specifications
    cat > $out/${ruby.gemPath}/specifications/${key}.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "${args.gemName}"
      s.version = "${args.version}"
      s.summary = "${args.gemName} (skipped)"
      s.require_paths = [${rp}]
      s.files = []
    end
    EOF
  ''
else
  buildRubyGem (
    builtins.removeAttrs args removedAttrs
    // {
      # For git+subdir, use "url" type (path-based install via bundler)
      # since the subdirectory is pre-extracted from the git repo
      type = if hasSubdir then "url" else source.type;
      source = builtins.removeAttrs source [ "type" ];
      platform = if platform != null then platform else "ruby";
      gemPath = buildGems;
      buildFlags = lib.optional (extconfFlags != "") extconfFlags;
      dontBuild = !needsUnpack;
    }
    // lib.optionalAttrs (preBuildHook != "") { preBuild = preBuildHook; }
    # Environment setup from preBuild also goes in preInstall since
    # extension compilation happens during gem install (installPhase)
    // lib.optionalAttrs (preBuild != "") { preInstall = preBuild; }
    // lib.optionalAttrs hasSubdir { src = gitSrc + "/${subdir}"; }
  )
