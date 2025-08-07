class Invoice < ApplicationRecord
  # アソシエーション
belongs_to :user
belongs_to :client
acts_as_taggable_on :tags


  # バリデーション
  validates :status, presence: true
  validates :receipt_method, presence: true
  validates :client_id, presence: true
  validates :due_date, presence: true
  validates :received_date, presence: true
  validates :is_qualified_invoice_issuer, presence: true
  validates :net_amount, presence: true
  validates :tax_amount, presence: true
  validates :total_amount, presence: true
  validates :tax_rate, presence: true


  
end
