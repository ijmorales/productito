require 'zeitwerk'

class Loader
  attr_accessor :loader, :env

  TEST_ONLY = %w[spec].freeze
  DEFAULT = %w[app app/models app/controllers lib].freeze

  def initialize(**kwargs)
    @loader = Zeitwerk::Loader.new
    @env = kwargs[:env]
  end

  def load
    attach_loader_paths
    loader.setup
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
      paths << TEST_ONLY if env == 'test'
      paths.flatten
    end
  end
end
