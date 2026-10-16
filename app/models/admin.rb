class Admin < ApplicationRecord
  # パスワードをハッシュ化して保存し、入力されたパスワードを照合する
  has_secure_password

  # メールアドレスを必須とし、同じアドレスの重複登録を防ぐ
  validates :email_address, presence: true, uniqueness: true
end