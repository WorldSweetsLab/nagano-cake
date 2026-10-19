class Public::ItemsController < Public::ApplicationController
allow_unauthenticated_access only: [:index, :show]

  def index
    @items = Item.includes(:genre).order(:id)
  end

  def show
    @item = Item.find(params[:id])
  end

end
