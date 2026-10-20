class Admin::OrdersController < Admin::ApplicationController
  # 購入者と注文明細をまとめて取得し、新しい注文から表示する
  def index
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc, id: :desc)
  end

  # 選択した注文と、その注文商品を取得する
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item).order(:id)

    # 注文時の税込単価と数量から商品合計を求める
    @items_total = @order_details.sum do |detail|
      detail.price * detail.amount
    end
  end
end