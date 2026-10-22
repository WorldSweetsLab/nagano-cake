class Public::OrdersController < Public::ApplicationController

  def new
    @order = Order.new
  end

  def confirm 
    select_address = params[:order][:select_address]
    @order = Order.new(order_params)
    @cart_items = Current.customer.cart_items

    if select_address == "0"
      @order.postal_code = Current.customer.postal_code
      @order.address = Current.customer.address
      @order.name = Current.customer.last_name + Current.customer.first_name

      elsif select_address == "1"
        @address = Current.customer.addresses.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name

      elsif select_address == "2"
    end
    @order.calculate_total_payment(@cart_items)
  end

  def create #注文確定処理工程
    @order = Current.customer.orders.new(order_params)
      cart_items = Current.customer.cart_items
      @order.calculate_total_payment(cart_items)

    ActiveRecord::Base.transaction do
      @order.save!

      Current.customer.cart_items.each do |cart_item|
        @order.order_details.create!(
        item_id: cart_item.item_id,
        amount: cart_item.amount,
        price: cart_item.item.with_tax_price
        )
      end

      Current.customer.cart_items.destroy_all
    end

    redirect_to complete_order_path(@order)
  rescue ActiveRecord::RecordInvalid
    redirect_to cart_items_path, alert: "注文を確定できませんでした。入力内容を確認してください。"   
  end

  def complete #注文完了画面
  end



  def index #注文履歴一覧
    @orders = Current.customer.orders
  end


  def show #注文履歴詳細画面
    @order = Current.customer.orders.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
