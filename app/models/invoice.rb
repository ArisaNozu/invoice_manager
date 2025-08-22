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

  validates :subject, length: { maximum: 100 }


  # ActiveHashの設定
  extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to_active_hash :status_master,            class_name: "Status",            foreign_key: :status
belongs_to_active_hash :receipt_method_master,    class_name: "ReceiptMethod",     foreign_key: :receipt_method
belongs_to_active_hash :tax_rate_master,          class_name: "TaxRate",           foreign_key: :tax_rate
belongs_to_active_hash :receipt_frequency_master, class_name: "ReceiptFrequency",  foreign_key: :receipt_frequency

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
