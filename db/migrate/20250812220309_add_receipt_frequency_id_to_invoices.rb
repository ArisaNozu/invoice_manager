class AddReceiptFrequencyIdToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :receipt_frequency_id, :integer, null: false
  end
end