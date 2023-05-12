require 'base64'
require 'dotenv'

module AuthenticationHelper
  def authenticated_request(method, path, options = {})
    credentials = "#{ENV['BASE_USER']}:#{ENV['BASE_PASSWORD']}"
    auth_header = "Basic #{Base64.strict_encode64(credentials)}"
    headers = { 'HTTP_AUTHORIZATION' => auth_header }.merge(options[:headers] || {})
    send(method, path, options[:params], headers)
  end
end
