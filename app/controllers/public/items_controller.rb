class Public::ItemsController < Public::ApplicationController
allow_unauthenticated_access only: [:index, :show]

  def index
    @items = Item.includes(:genre).order(created_at: :desc).page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

end
