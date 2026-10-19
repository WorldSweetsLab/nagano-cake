class Admin::CustomersController < Admin::ApplicationController
  # 登録されている会員をID順に取得する
  def index
    @customers = Customer.order(:id)
  end

  # URLのIDに対応する会員を取得する
  def show
    @customer = Customer.find(params[:id])
  end
end