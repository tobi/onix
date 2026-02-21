require "bundler/gem_tasks"

desc "Install gem then symlink lib/ and exe/ from gem dir back to working tree"
task "install:link" => :install do
  spec = Gem::Specification.find_by_name("onix")
  gem_dir = spec.gem_dir

  # Replace installed lib/ with symlink to working tree
  installed_lib = File.join(gem_dir, "lib")
  FileUtils.rm_rf(installed_lib)
  FileUtils.ln_s(File.expand_path("lib"), installed_lib)
  puts "Linked #{installed_lib} → lib/"

  # Replace installed exe/ with symlink to working tree
  installed_exe = File.join(gem_dir, "exe")
  FileUtils.rm_rf(installed_exe)
  FileUtils.ln_s(File.expand_path("exe"), installed_exe)
  puts "Linked #{installed_exe} → exe/"
end

desc "Run tests"
task :test do
  tests = Dir["test/**/*_test.rb"].sort
  abort "No tests found" if tests.empty?
  ruby "-Ilib:test", "-e", 'Dir["test/**/*_test.rb"].sort.each { |f| load f }'
end

task default: "install:link"
