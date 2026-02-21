# frozen_string_literal: true

require "minitest/autorun"
require "pathname"
require "tmpdir"
require "fileutils"

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
scint_path = File.expand_path("../../scint/lib", __dir__)
$LOAD_PATH.unshift(scint_path) if Dir.exist?(scint_path)

module OnixTestHelpers
  def fixture_path(*parts)
    File.expand_path(File.join("fixtures", *parts), __dir__)
  end
end

class Minitest::Test
  include OnixTestHelpers
end
