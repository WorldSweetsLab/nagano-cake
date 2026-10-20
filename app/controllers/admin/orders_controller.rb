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
    # 注文ステータスを更新する
  def update
    @order = Order.find(params[:id])
    attributes = order_params

    # 定義されていないステータスは保存しない
    unless Order.statuses.key?(attributes[:status])
      return redirect_to admin_order_path(@order),
                         alert: "注文ステータスを選択してください。"
    end

    if @order.update(attributes)
      redirect_to admin_order_path(@order),
                  notice: "注文ステータスを更新しました。"
    else
      redirect_to admin_order_path(@order),
                  alert: "注文ステータスを更新できませんでした。"
    end
  end

  private

  # この画面からは注文ステータスだけ更新を許可する
  def order_params
    params.require(:order).permit(:status)
  end
end