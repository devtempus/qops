class Quotation < ApplicationRecord

  has_many :categories_quotations
  has_and_belongs_to_many :categories, through: :categories_quotations

  has_many :tags_quotations
  has_and_belongs_to_many :tags, through: :tags_quotations

  belongs_to :author

  validates :text, presence: true

  scope :publicated, -> { includes(:tags).where(publicated: true)}
end
