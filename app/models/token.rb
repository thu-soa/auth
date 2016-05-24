require 'active_record'
require 'foreigner'

class Token < ActiveRecord::Base
  belongs_to :user
  after_initialize :init_defaults

  def init_defaults
    self.valid_until ||= Time.now + 2.years
  end
end