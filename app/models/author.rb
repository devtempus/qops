class Author < ApplicationRecord
  has_many :quotations, dependent: :destroy
  validates_presence_of :full_name
  scope :publicated, -> { where(publicated: true)}
end
