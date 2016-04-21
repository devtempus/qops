class Author < ActiveRecord::Base
  has_many :quotations, dependent: :destroy
end