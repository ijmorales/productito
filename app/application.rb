require_relative '../lib/router'

class Application
  def call(env)
    handle_request(Rack::Request.new(env))
  end

  private

  def handle_request(request)
    Router.new(request:).route
  end
end
