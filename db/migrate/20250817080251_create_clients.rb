class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string  :client_code, null: false
      t.string  :name, null: false
      t.string  :invoice_registration_number
      t.boolean :is_qualified_invoice_issuer, null: false, default: false
      t.string  :contact_person
      t.string  :phone_number
      t.text    :address
      t.text    :notes
      t.timestamps
    end
    add_index :clients, :client_code, unique: true
    add_index :clients, :name
    add_index :clients, :invoice_registration_number, unique: true
  end
end