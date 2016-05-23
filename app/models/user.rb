require 'active_record'
require 'foreigner'
require 'securerandom'
require_relative 'token'

TOKEN_LENGTH = 24

class User < ActiveRecord::Base
  has_many :oauth_tokens
  has_many :tokens

  def create_token
    Token.create(user_id: self.id, token_string: SecureRandom.hex(TOKEN_LENGTH))
  end
end