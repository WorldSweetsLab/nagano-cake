class Public::ItemsController < Public::ApplicationController
allow_unauthenticated_access only: [:index, :show]

  def index
    @items = Item.all
    if params[:genre_id].present?
      @items = Item.where(genre_id: params[:genre_id])
      @genre =Genre.find(params[:genre_id])
    end
    @items = @items.includes(:genre).order(created_at: :desc).page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

end
