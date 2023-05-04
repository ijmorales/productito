require 'rack/test'
require_relative '../config/loader'

Loader.new(paths: %w[app spec]).setup

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
