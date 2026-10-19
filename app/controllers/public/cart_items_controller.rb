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
    @cart_item = Current.customer.cart_items.new(cart_item_params)
    existing_cart_item = Current.customer.cart_items.find_by(item_id: @cart_item.item_id)
    if existing_cart_item
      existing_cart_item.amount += @cart_item.amount
      if existing_cart_item.save
        redirect_to cart_items_path
      else
        redirect_to cart_items_path, alert: "カートに追加できませんでした"
      end
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
        redirect_to cart_items_path, alert: "カートに追加できませんでした"
      end
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
