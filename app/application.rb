require 'rack'
require 'rack/contrib'
require 'dotenv'

class Application
  def initialize
    static_opts = static_options

    @app = Rack::Builder.new do
      use Rack::ETag
      use Rack::ConditionalGet
      use Rack::Static, static_opts
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

  private

  def static_options
    {
      urls: ['/AUTHORS'],
      root: '.',
      header_rules: [
        [:all, { 'cache-control' => 'public, max-age=86400' }]
      ]
    }
  end
end
