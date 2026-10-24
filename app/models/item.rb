class Item < ApplicationRecord
  belongs_to :genre
# カートや注文で使われている商品は削除できないようにする
has_many :cart_items, dependent: :restrict_with_error
has_many :order_details, dependent: :restrict_with_error
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :image, presence: true

  def get_item_image(width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end
  ## 消費税を求める
  def with_tax_price
    (price * 1.1).floor
  end

end
