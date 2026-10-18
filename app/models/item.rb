class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image

  validates :name, :description, presence: true

  validates :price, numericality: {
  only_integer: true,
  greater_than_or_equal_to: 0
}

  validates :is_active, inclusion: { in: [true, false] }
end
