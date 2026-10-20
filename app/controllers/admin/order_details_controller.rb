class Admin::OrderDetailsController < Admin::ApplicationController
  # 注文商品ごとの製作ステータスを更新する
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    attributes = order_detail_params

    unless OrderDetail.making_statuses.key?(attributes[:making_status])
      return redirect_to admin_order_path(@order),
                         alert: "製作ステータスを選択してください。"
    end

    OrderDetail.transaction do
      @order_detail.update!(attributes)

      # 製作ステータスが変わった場合だけ、注文側も確認する
      if @order_detail.saved_change_to_making_status?
        details = @order.order_details

        if !details.where.not(making_status: :production_complete).exists?
          # 全商品が製作完了なら、発送準備中にする
          @order.update!(status: :preparing)
        elsif details.where(making_status: :in_production).exists?
          # 製作中の商品が1つでもあれば、注文も製作中にする
          @order.update!(status: :making)
        end
      end
    end

    redirect_to admin_order_path(@order),
                notice: "製作ステータスを更新しました。"
  rescue ActiveRecord::RecordInvalid
    redirect_to admin_order_path(@order),
                alert: "ステータスを更新できませんでした。"
  end

  private

  # 製作ステータスだけ更新を許可する
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end