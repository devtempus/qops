class Author < ActiveRecord::Base
  has_many :quotations, dependent: :destroy
  validates_presence_of :full_name
end