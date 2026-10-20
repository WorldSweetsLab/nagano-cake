class Admin::OrdersController < Admin::ApplicationController
  # 購入者と注文明細をまとめて取得し、新しい注文から表示する
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc, id: :desc)
  end
end