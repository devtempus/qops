class RenameQuotationsCategoriesToCategoriesQuotations < ActiveRecord::Migration
  def change
    rename_table :quotations_categories, :categories_quotations
  end
end
