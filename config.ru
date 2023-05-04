require 'debug'
require_relative 'config/loader'

Loader.new(paths: ['app']).setup

run Application.new
