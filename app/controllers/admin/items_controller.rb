class Admin::ItemsController < Admin::ApplicationController
 
  # 商品をID順に、1ページ10件ずつ取得する
  def index
    @items = Item.includes(:genre)
                 .order(:id)
                 .page(params[:page])
                 .per(10)
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

    # 編集する商品と、選択肢のジャンルを取得する
    def edit
    @item = Item.find(params[:id])
     @genres = Genre.order(:id)
    end

# 入力内容で既存の商品を更新する
def update
  @item = Item.find(params[:id])

  if @item.update(item_params)
    redirect_to admin_item_path(@item)
  else
    # 更新できなかった場合は編集画面を再表示する
    @genres = Genre.order(:id)
     render :edit, status: :unprocessable_entity
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