require 'zeitwerk'

class Loader
  attr_accessor :loader

  def initialize(**kwargs)
    @loader = Zeitwerk::Loader.new
    setup_paths(kwargs[:paths])
  end

  def setup
    loader.setup
  end

  private

  def setup_paths(paths)
    paths.each { |p| loader.push_dir(File.expand_path(p)) }
  end
end
