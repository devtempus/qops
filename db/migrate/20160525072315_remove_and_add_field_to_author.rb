class RemoveAndAddFieldToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :full_name, :string, null: true
    remove_column :authors, :first_name
    remove_column :authors, :last_name
  end
end
