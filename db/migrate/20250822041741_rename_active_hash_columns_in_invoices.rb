class RenameActiveHashColumnsInInvoices < ActiveRecord::Migration[7.1]
  def change
    rename_column :invoices, :receipt_frequency_id, :receipt_frequency rescue nil
  end
end
