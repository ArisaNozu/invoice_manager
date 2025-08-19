class Invoice < ApplicationRecord
  # アソシエーション
belongs_to :user
belongs_to :client, foreign_key: :client_code, primary_key: :client_code, optional: true
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
  validates :tax_rate, presence: true


  # 合計金額＝本体価格＋消費税額
  def total_amount
    net_amount + tax_amount
  end
  
end
