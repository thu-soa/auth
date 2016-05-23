require 'sinatra'
require './main'
require './app/models/user'
require './app/models/token'
require './errors'

#  OAuth 2.0
# require 'rack-oauth2'
# authorization_endpoint = Rack::OAuth2::Server::Authorize.new do |req, res|
#   client = User.find_by_id(req.client_id)
#   req.bad_request! if client.blank?
#   res.redirect_uri = req.verify_redirect_uri!(client.redirect_uri)
#   if req.post?
#     if params[:approve]
#       case req.response_type
#         when :code
#           authorization_code = current_account.authorization_codes.create(
#               client: client,
#               redirect_uri: res.redirect_uri
#           )
#           res.code = authorization_code.token
#         when :token
#           req.unsupported_response_type!
#       end
#       res.approve!
#     else
#       req.access_denied!
#     end
#   else
#     [404, [], []]
#   end
# end
#
# authorization_endpoint.call request.env

get '/api/v1/user_info' do
  token = params['token']
  begin
    if token && (t = Token.find_by_token_string(token))
      {
          status:   :ok,
          user_id:  t.user.id,
          username: t.user.name,
          user_type:t.user.user_type
      }.to_json
    else
      er 'no token'
    end
  rescue ActiveRecord::ConnectionTimeoutError
    er 'frequency too high'
  end
end

post '/api/v1/login' do
  username = params['username']
  password = params['password']
  if username && password
    if (user = User.find_by_name(username))
      {
          status:   :ok,
          user_id:  user.id,
          token:    user.create_token.token_string
      }.to_json
    else
      er 'user not found'
    end
  else
    er 'parameters error'
  end

end

