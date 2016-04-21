class CategoriesQuotation < ActiveRecord::Base
  belongs_to :category
  belongs_to :quotation
end
