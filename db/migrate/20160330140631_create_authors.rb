class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :short_name
      t.string :pseudonym
      t.string :date_birth
    end

    add_index :authors, :first_name, unique: true
    add_index :authors, :short_name, unique: true
  end
end
