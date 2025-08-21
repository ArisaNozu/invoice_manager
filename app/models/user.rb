class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invoices, dependent: :nullify

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :department_master, class_name: "Department", foreign_key: :department

  # バリデーション
  validates :full_name, presence: true
  validates :employee_number, presence: true, uniqueness: true
  validates :department, presence: true, numericality: { other_than: 0, message: "を選択してください" }
  
end