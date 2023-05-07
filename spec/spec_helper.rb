require 'rack/test'
require 'debug'
require_relative '../config/loader'

Loader.load(env: :test)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
