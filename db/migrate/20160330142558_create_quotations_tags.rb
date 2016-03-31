class CreateQuotationsTags < ActiveRecord::Migration
  def change
    create_table :quotations_tags, id: false do |t|
      t.belongs_to :quotation, index: true
      t.belongs_to :tag,       index: true
    end
  end
end
