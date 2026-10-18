class Admin < ApplicationRecord
  # パスワードをハッシュ化して保存し、入力されたパスワードを照合する
  has_secure_password

  # 管理者1人に複数のログイン記録を紐付ける
  has_many :sessions, dependent: :destroy


  # メールアドレスを必須とし、同じアドレスの重複登録を防ぐ
  validates :email_address, presence: true, uniqueness: true

  # メールアドレスの前後の空白を除き、英字を小文字にそろえる
normalizes :email_address, with: ->(email) { email.strip.downcase }
end