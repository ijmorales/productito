require 'base64'

class BasicAuthMiddleware
  def initialize(app, username, password)
    @app = app
    @username = username
    @password = password
  end

  def call(env)
    if authorized?(env['HTTP_AUTHORIZATION'])
      @app.call(env)
    else
      unauthorized_response
    end
  end

  private

  def authorized?(auth_header)
    scheme, credentials = auth_header&.split(' ')
    return false unless scheme == 'Basic'

    provided_username, provided_password = decode_credentials(credentials)
    provided_username == @username && provided_password == @password
  end

  def decode_credentials(encoded_credentials)
    Base64.decode64(encoded_credentials).split(':', 2)
  end

  def unauthorized_response
    [
      401,
      { 'content-type' => 'text/plain', 'www-authenticate' => 'Basic realm="Restricted Area"' },
      ['Unauthorized']
    ]
  end
end
