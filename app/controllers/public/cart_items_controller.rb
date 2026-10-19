class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = Current.customer.cart_items
    @total_price = 0
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end

end
