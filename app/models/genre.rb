class Genre < ApplicationRecord
  # 1つのジャンルに複数の商品が属する
    has_many :items

  # ジャンル名が未入力・空白のみの場合は保存できないようにする
    validates :name, presence: true
end
