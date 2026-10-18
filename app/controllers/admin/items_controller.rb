class Admin::ItemsController < Admin::ApplicationController
  # 商品一覧に表示する商品とジャンルを取得する
  def index
    @items = Item.includes(:genre).order(:id)
  end

    # URLの商品IDに対応する商品を取得する
  def show
    @item = Item.find(params[:id])
  end
end