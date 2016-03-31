class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.references :author, index: true
      t.string :text
      t.text :full_text

      t.timestamps
    end

    add_index :quotations, :text, unique: true
  end
end
