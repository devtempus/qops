class Users < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :encrypted_password
end
