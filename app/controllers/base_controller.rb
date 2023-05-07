class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def not_found
    respond('Not found', status: 404)
  end

  private

  def respond(body, status: 200)
    [status, {}, [body]]
  end
end
