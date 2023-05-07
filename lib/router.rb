class Router
  attr_reader :request

  def initialize(**kwargs)
    @request = kwargs[:request]
  end

  # Determines which controller we should use and calls the action on it. Returns a response.
  def route
    controller_klass.new(request).send(action)
  rescue NameError
    BaseController.new(request).not_found
  end

  private

  def resource
    result = Matcher.match(request.path)
    resource = result.delete(:resource)
    params = result
    request.params.merge!(params) if params

    resource
  end

  def controller_klass
    Object.const_get(controller_name)
  end

  def controller_name
    [resource.capitalize, 'Controller'].join
  end

  def action
    case request.request_method
    when 'GET'
      request.params[:id] ? :show : :index
    when 'POST'
      :create
    when 'PUT'
      :update
    when 'DELETE'
      :destroy
    end
  end
end
