class Tag < ApplicationRecord
  has_many :tags_quotations
  has_and_belongs_to_many :quotations, through: :tags_quotations

  validates_presence_of :name
end
