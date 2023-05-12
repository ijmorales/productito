require 'zeitwerk'
require 'dotenv'

class Loader
  attr_accessor :loader, :env

  TEST_ONLY = %w[spec spec/support].freeze
  DEFAULT = %w[app app/models app/controllers app/middlewares lib].freeze

  def initialize(**kwargs)
    @loader = Zeitwerk::Loader.new
    @env = kwargs[:env]
  end

  def load
    attach_loader_paths
    loader.setup
    load_env_variables
  end

  def self.load(**kwargs)
    new(**kwargs).load
  end

  private

  def attach_loader_paths
    paths.each { |p| loader.push_dir(File.expand_path(p)) }
  end

  def paths
    @paths ||= begin
      paths = []
      paths << DEFAULT
      paths << TEST_ONLY if env == :test
      paths.flatten
    end
  end

  def load_env_variables
    Dotenv.load(".env.#{env}")
  end
end
