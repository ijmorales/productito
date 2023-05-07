require 'debug'
require_relative 'config/loader'

Loader.load(env: ENV['RACK_ENV']&.to_sym || :development)

run Application.new
