class RemoveClientAndInvoiceColumnsFromInvoices < ActiveRecord::Migration[6.1]
  def change
    # client_id 削除（外部キー付き）
    if column_exists?(:invoices, :client_id)
      remove_reference :invoices, :client, foreign_key: true
    end

    # invoice_registration_number 削除
    if column_exists?(:invoices, :invoice_registration_number)
      remove_column :invoices, :invoice_registration_number, :string
    end

    # is_qualified_invoice_issuer 削除
    if column_exists?(:invoices, :is_qualified_invoice_issuer)
      remove_column :invoices, :is_qualified_invoice_issuer, :boolean
    end
  end
end