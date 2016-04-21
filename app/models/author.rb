class Author < ActiveRecord::Base
  has_many :quotations, dependent: :destroy
  validates_presence_of :first_name, :last_name
end