require 'sinatra'
require './main'
require './app/models/user'
require './app/models/token'
require './errors'
require 'sinatra/cross_origin'
require 'digest'

configure do
  enable :cross_origin
end
after do
  ActiveRecord::Base.connection.close
end

get '/api/v1/user_info' do
  token = params['token']
  begin
    if token && (t = Token.find_by_token_string(token))
      if t.valid_until > Time.now
        {
            status:   :ok,
            user_id:  t.user.id,
            username: t.user.name,
            user_type:t.user.user_type
        }.to_json
      else
        er 'token expired'
      end
    else
      er 'no token'
    end
  rescue ActiveRecord::ConnectionTimeoutError
    er 'database connection error'
  end
end

post '/api/v1/register' do
  username = params['username']
  password = params['password']
  if username && password
    user = User.find_by_name(username)
    er 'user already exist' if user
    user = User.create(name: username, user_type: 'user', password_md5: Digest::MD5.hexdigest(password))
    if user
      {
          status: :ok,
          user_id: user.id,
          token: user.create_token.token_string
      }.to_json
    else
      er 'failed to create user'
    end
  else
    er 'parameters error'
  end
end

post '/api/v1/login' do
  username = params['username']
  password = params['password']
  if username && password
    if (user = User.find_by_name(username))
      if user.password_md5 == Digest::MD5.hexdigest(password)
        {
            status:   :ok,
            user_id:  user.id,
            token:    user.create_token.token_string
        }.to_json
      else
        er 'wrong password'
      end
    else
      er 'user not found'
    end
  else
    er 'parameters error'
  end
end


