require 'json'

class Router
  class Params
    def self.parse_body_params(request)
      content = request.body.read
      return {} unless request.content_type == 'application/json' && content.size.positive?

      JSON.parse(content)
    end
  end
end
