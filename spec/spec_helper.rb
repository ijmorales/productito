require 'rack/test'
require 'debug'
require_relative '../config/loader'
require_relative 'support/reset_test_db_helper'
require_relative 'support/authentication_helper'

Loader.load(env: :test)

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ResetTestDbHelper, reset_test_db: true
  config.after(:each, reset_test_db: true) do
    reset_test_db
  end
end
