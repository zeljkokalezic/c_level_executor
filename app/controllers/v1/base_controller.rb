class V1::BaseController < ActionController::API
  include Response
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      #TODO: proper authorization
      api_auth_token = ENV['API_AUTH_TOKEN'] || 'a47a8e54b11c4de5a4a351734c80a14a'
      token == api_auth_token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end
end
