class AddPublicationDateAndPublishedFieldsToQoutationsTable < ActiveRecord::Migration
  def change
    add_column :quotations, :publicated, :boolean, default: false
    add_column :quotations, :publicated_date, :datetime
  end
end
