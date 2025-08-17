class AddClientCodeToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :client_code, :integer, null: false
  end
end
