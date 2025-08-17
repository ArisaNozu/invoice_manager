class RemoveTotalAmountFromInvoices < ActiveRecord::Migration[7.1]
  def change
    remove_column :invoices, :total_amount, :integer
  end
end
