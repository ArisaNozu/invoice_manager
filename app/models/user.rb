class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ActiveHash（department）との関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :department

  # バリデーション
  validates :full_name, presence: true
  validates :employee_number, presence: true, uniqueness: true
  validates :department_id, presence: true, numericality: { other_than: 0, message: "を選択してください" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true


end
