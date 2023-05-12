require 'rack/builder'
require 'dotenv'

class Application
  def initialize
    @app = Rack::Builder.new do
      use BasicAuthMiddleware, ENV['BASE_USER'], ENV['BASE_PASSWORD']
      run proc { |env| Application.new.handle_request(env) }
    end.to_app
  end

  def call(env)
    @app.call(env)
  end

  def handle_request(env)
    Router.new(request: Rack::Request.new(env)).route
  end
end
