class Tag < ApplicationRecord
  has_many :tags_quotations
  has_and_belongs_to_many :quotations, through: :tags_quotations

  validates :name, presence: true, length: { maximum: 128 }
  validates :name, uniqueness: true
end
