class RemoveTotalAmountFromInvoices < ActiveRecord::Migration[6.1]
  def up
    remove_column :invoices, :total_amount if column_exists?(:invoices, :total_amount)
  end

  def down
    # 復元用（必要なら）
    add_column :invoices, :total_amount, :integer unless column_exists?(:invoices, :total_amount)
  end
end