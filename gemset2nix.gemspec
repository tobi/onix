Gem::Specification.new do |s|
  s.name        = "gemset2nix"
  s.version     = "0.5.0"
  s.summary     = "Convert Ruby Gemfile.lock to hermetic Nix derivations"
  s.description = "Generates per-gem Nix derivations from a Gemfile.lock, " \
                  "with auto-detection of native dependencies, overlay support, " \
                  "and bundler-compatible BUNDLE_PATH layout."
  s.authors     = ["Tobi Lütke"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/tobi/gemset2nix"

  s.required_ruby_version = ">= 3.1"

  s.files         = Dir["lib/**/*.rb", "exe/*", "LICENSE", "README.md"]
  s.bindir        = "exe"
  s.executables   = ["gemset2nix"]
  s.require_paths = ["lib"]

  s.add_dependency "bundler", ">= 2.0"
end
