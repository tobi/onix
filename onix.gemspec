require_relative "lib/onix/version"

Gem::Specification.new do |s|
  s.name        = "onix"
  s.version     = Onix::VERSION
  s.summary     = "Convert lockfiles to hermetic Nix derivations"
  s.description = "Generates per-package Nix derivations from Gemfile.lock or pnpm-lock.yaml, " \
                  "with auto-detection of native dependencies, overlay support, " \
                  "bundler-compatible BUNDLE_PATH layout, and pnpm-compatible node_modules."
  s.authors     = ["Tobi Lütke"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/tobi/onix"

  s.required_ruby_version = ">= 3.1"

  s.files         = Dir["lib/**/*.rb", "lib/**/*.nix", "exe/*", "docs/*.md", "LICENSE", "README.md"]
  s.bindir        = "exe"
  s.executables   = ["onix"]
  s.require_paths = ["lib"]

  s.add_dependency "scint", ">= 0.1"
end
