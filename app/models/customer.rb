class Customer < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
 
  
  validates :password, length: { minimum: 6 }, on: :create
end
