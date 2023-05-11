require 'json'

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
    [status, headers, [body.to_json]]
  end

  def headers
    {
      'content-type' => 'application/json'
    }
  end

  def params
    request.params
  end
end
