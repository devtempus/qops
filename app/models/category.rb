class Category < ApplicationRecord
  include TreeCategories

  has_many :categories_quotations
  has_and_belongs_to_many :quotations, through: :categories_quotations


  validates :name, presence: true
  validates :name, uniqueness: true

  scope :publicated, -> { where(published: true)}
end
