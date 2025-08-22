class Invoice < ApplicationRecord
  # アソシエーション
belongs_to :user
belongs_to :client, foreign_key: :client_code, primary_key: :client_code, optional: true
acts_as_taggable_on :tags

  # バリデーション
  validates :status, presence: true
  validates :receipt_method, presence: true
  validates :client_code, presence: true
  validates :due_date, presence: true
  validates :received_date, presence: true
  validates :net_amount, presence: true
  validates :tax_amount, presence: true
  validates :tax_rate, presence: true
  validates :transaction_date, presence: true

  validates :net_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :tax_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  # 合計金額＝本体価格＋消費税額
  def total_amount
    net_amount.to_i + tax_amount.to_i
  end


before_validation :normalize_amounts

private

  def normalize_amounts
    self.net_amount = net_amount.to_s.delete(',') if net_amount.present?
    self.tax_amount = tax_amount.to_s.delete(',') if tax_amount.present?
  end

  
end
