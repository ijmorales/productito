require 'logger'

module Concerns
  module Loggable
    def self.included(base)
      base.extend self
    end

    def log(level, message)
      logger.send(level, message)
    end

    private

    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end
