class Public::OrdersController < Public::ApplicationController

  def new
    @order = Order.new
    @postal_code = Current.customer.postal_code
  end
end
