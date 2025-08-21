class AddTransactionDateToInvoices < ActiveRecord::Migration[7.1]
  def up
    add_column :invoices, :transaction_date, :date, null: true
    add_index  :invoices, :transaction_date

    # 既存データの埋め（任意）: 無ければ受領日で埋める例
    execute <<~SQL.squish
      UPDATE invoices
      SET transaction_date = received_date
      WHERE transaction_date IS NULL AND received_date IS NOT NULL
    SQL

    # 取引日を必須にしたい場合
    change_column_null :invoices, :transaction_date, false
  end

  def down
    remove_index  :invoices, :transaction_date
    remove_column :invoices, :transaction_date
  end
end