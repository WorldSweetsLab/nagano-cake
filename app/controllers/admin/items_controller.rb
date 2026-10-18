class Admin::ItemsController < Admin::ApplicationController
  # 商品一覧に表示する商品とジャンルを取得する
  def index
    @items = Item.includes(:genre).order(:id)
  end

  # URLの商品IDに対応する商品を取得する
  def show
    @item = Item.find(params[:id])
  end

  # 登録フォーム用の商品と、選択肢のジャンルを用意する
  def new
    @item = Item.new
    @genres = Genre.order(:id)
  end

  # フォームから受け取った内容で商品を保存する
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item)
    else
      # 保存できなかった場合も、ジャンルの選択肢を用意する
      @genres = Genre.order(:id)
      render :new, status: :unprocessable_entity
    end
  end

  private

  # 商品の登録で受け付ける項目を指定する
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :genre_id,
      :price,
      :image,
      :is_active
    )
  end
end