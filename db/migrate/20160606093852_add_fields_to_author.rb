class AddFieldsToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :publicated, :boolean, default: true
    add_column :authors, :description, :string
    add_column :authors, :burn_date, :date
    add_column :authors, :die_date, :date
    remove_column :authors, :short_name
    remove_column :authors, :date_birth
  end
end
