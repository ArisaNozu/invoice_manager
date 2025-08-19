class AdjustInvoicesSchemaForRequirements < ActiveRecord::Migration[7.1]
  def up
    add_column :invoices, :status, :integer, null: false   unless column_exists?(:invoices, :status)
    add_column :invoices, :receipt_method, :integer, null: false unless column_exists?(:invoices, :receipt_method)

    add_column :invoices, :due_date, :date, null: false    unless column_exists?(:invoices, :due_date)
    add_column :invoices, :received_date, :date, null: false unless column_exists?(:invoices, :received_date)

    add_column :invoices, :net_amount, :integer, null: false unless column_exists?(:invoices, :net_amount)
    add_column :invoices, :tax_amount, :integer, null: false unless column_exists?(:invoices, :tax_amount)
    add_column :invoices, :tax_rate, :integer, null: false unless column_exists?(:invoices, :tax_rate)

    add_column :invoices, :memo, :text                     unless column_exists?(:invoices, :memo)

    # client_code は string に統一（clients.client_code が string のため）
    if column_exists?(:invoices, :client_code)
      unless column_exists?(:invoices, :client_code, :string)
        remove_index :invoices, :client_code if index_exists?(:invoices, :client_code)
        change_column :invoices, :client_code, :string, null: false
        add_index :invoices, :client_code unless index_exists?(:invoices, :client_code)
      end
    else
      add_column :invoices, :client_code, :string, null: false
      add_index  :invoices, :client_code unless index_exists?(:invoices, :client_code)
    end

  end

end