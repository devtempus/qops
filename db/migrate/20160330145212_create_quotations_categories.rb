class CreateQuotationsCategories < ActiveRecord::Migration
  def change
    create_table :quotations_categories, id: false do |t|
      t.belongs_to :quotation, index: true
      t.belongs_to :category,  index: true
    end
  end
end
