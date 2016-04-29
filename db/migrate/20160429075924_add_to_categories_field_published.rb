class AddToCategoriesFieldPublished < ActiveRecord::Migration
  def change
    add_column :categories, :published, :boolean, default: true
  end
end
