class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.integer :status,                      null: false
      t.integer :receipt_method,              null: false
      t.references :client,                   null: false, foreign_key: true
      t.date    :due_date,                    null: false
      t.date    :received_date,               null: false
      t.string  :invoice_registration_number
      t.boolean :is_qualified_invoice_issuer, null: false
      t.integer :net_amount,                  null: false
      t.integer :tax_amount,                  null: false
      t.integer :total_amount,                null: false
      t.decimal :tax_rate, precision: 5, scale: 2, null: false
      t.text    :memo
      t.timestamps
    end
  end
end
