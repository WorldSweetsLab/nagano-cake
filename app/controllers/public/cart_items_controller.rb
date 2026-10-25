class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = Current.customer.cart_items
    @total_price = 0
  end

  def update
    @cart_item = Current.customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params.slice(:amount))
      redirect_to cart_items_path, notice: "数量を変更しました"
    else
      redirect_to cart_items_path, alert: "数量を変更できませんでした"
    end
  end

  def destroy
    @cart_item = Current.customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "カートから商品を削除しました"
  end

  def destroy_all
    @cart_items = Current.customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました"
  end

  def create
    @cart_item = Current.customer.cart_items.new(cart_item_params)
    existing_cart_item = Current.customer.cart_items.find_by(item_id: @cart_item.item_id)
    unless @cart_item.valid?
      return redirect_to cart_items_path, alert: "カートに追加できませんでした"
    end
    unless @cart_item.item.is_active?
      return redirect_to cart_items_path, alert: "販売停止中の商品はカートに追加できません"
    end
    if existing_cart_item
      existing_cart_item.amount += @cart_item.amount
      if existing_cart_item.save
        redirect_to cart_items_path, notice: "カートに商品を追加しました"
      else
        redirect_to cart_items_path, alert: "カートに追加できませんでした"
      end
    else
      if @cart_item.save
        redirect_to cart_items_path, notice: "カートに商品を追加しました"
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
