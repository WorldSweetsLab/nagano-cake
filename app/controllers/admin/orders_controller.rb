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
    # 注文ステータスと、必要に応じて製作ステータスを更新する
  def update
    @order = Order.find(params[:id])
    attributes = order_params

    unless Order.statuses.key?(attributes[:status])
      return redirect_to admin_order_path(@order),
                         alert: "注文ステータスを選択してください。"
    end

    # 注文と注文商品の変更をセットで保存する
    Order.transaction do
      @order.update!(attributes)

      # 入金確認に変わったとき、全注文商品を製作待ちにする
      if @order.saved_change_to_status? && @order.paid_confirmation?
        @order.order_details.each do |detail|
          detail.update!(making_status: :waiting_production)
        end
      end
    end

    redirect_to admin_order_path(@order),
                notice: "注文ステータスを更新しました。"
  rescue ActiveRecord::RecordInvalid
    redirect_to admin_order_path(@order),
                alert: "ステータスを更新できませんでした。"
  end

  private

  # この画面からは注文ステータスだけ更新を許可する
  def order_params
    params.require(:order).permit(:status)
  end
end