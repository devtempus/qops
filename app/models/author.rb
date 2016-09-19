#need to delete because I create Table User/ Added role permision for user. And I think we do not need this model and table
class Author < ApplicationRecord
  has_many :quotations, dependent: :destroy
  validates_presence_of :full_name
  validates_uniqueness_of :full_name


  scope :publicated, -> { where(publicated: true)}
end
