class Category < ActiveRecord::Base
  include TreeCategories

  has_many :categories_quotations
  has_and_belongs_to_many :quotations, through: :categories_quotations
  validates_presence_of :name

  scope :publicated, -> { where(published: true)}
end
