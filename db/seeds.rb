# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
  ["ケーキ", "プリン", "焼き菓子", "キャンディ"].each do |genre_name|
    Genre.find_or_create_by!(name: genre_name)
  end

  item = Item.find_or_create_by!(name: "ダミーケーキ") do |i|
    i.genre = Genre.find_by!(name: "ケーキ")
    i.description = "ダミーケーキの説明です"
    i.price = 700
    i.is_active = true
  end
  unless item.image.attached?
    item.image.attach(
      io: File.open(Rails.root.join("app/assets/images/dummy_cake.jpg")),
      filename: "dummy_cake.jpg"
    )
  end

  item = Item.find_or_create_by!(name: "ダミープリン") do |i|
    i.genre = Genre.find_by!(name: "プリン")
    i.description = "ダミープリンの説明です"
    i.price = 600
    i.is_active = true
  end
  unless item.image.attached?
    item.image.attach(
      io: File.open(Rails.root.join("app/assets/images/dummy_pudding.jpg")),
      filename: "dummy_pudding.jpg"
    )
  end

  item = Item.find_or_create_by!(name: "ダミー焼き菓子") do |i|
    i.genre = Genre.find_by!(name: "焼き菓子")
    i.description = "ダミー焼き菓子の説明です"
    i.price = 500
    i.is_active = true
  end
  unless item.image.attached?
  item.image.attach(
    io: File.open(Rails.root.join("app/assets/images/dummy_baked.jpg")),
    filename: "dummy_baked.jpg"
    )
  end

  item = Item.find_or_create_by!(name: "ダミーキャンディ") do |i|
    i.genre = Genre.find_by!(name: "キャンディ")
    i.description = "ダミーキャンディの説明です"
    i.price = 400
    i.is_active = true
  end
  unless item.image.attached?
    item.image.attach(
      io: File.open(Rails.root.join("app/assets/images/dummy_candy.jpg")),
      filename: "dummy_candy.jpg"
    )
  end