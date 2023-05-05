class Application
  def call(_env)
    [200, {}, ['Hello World']]
  end
end
