require_relative "boot"
require "rails/all"

module Synthetic
  class Application < Rails::Application
    config.load_defaults 8.0
  end
end
