require_relative "lib/onix/version"

Gem::Specification.new do |s|
  s.name        = "onix"
  s.version     = Onix::VERSION
  s.summary     = "Convert Ruby Gemfile.lock to hermetic Nix derivations"
  s.description = "Generates per-gem Nix derivations from a Gemfile.lock, " \
                  "with auto-detection of native dependencies, overlay support, " \
                  "and bundler-compatible BUNDLE_PATH layout."
  s.authors     = ["Tobi Lütke"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/tobi/onix"

  s.required_ruby_version = ">= 3.1"

  s.files         = Dir["lib/**/*.rb", "lib/**/*.nix", "exe/*", "LICENSE", "README.md"]
  s.bindir        = "exe"
  s.executables   = ["onix"]
  s.require_paths = ["lib"]

  s.add_dependency "scint", ">= 0.1"
end
