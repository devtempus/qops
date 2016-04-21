class Category < ActiveRecord::Base
  has_many :categories_quotations
  has_and_belongs_to_many :quotations, through: :categories_quotations
  validates_presence_of :name
end
