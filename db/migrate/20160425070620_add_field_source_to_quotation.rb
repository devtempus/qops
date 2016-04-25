class AddFieldSourceToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :source, :string
  end
end
