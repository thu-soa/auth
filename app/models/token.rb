require 'active_record'
require 'foreigner'

class Token < ActiveRecord::Base
  belongs_to :user
end