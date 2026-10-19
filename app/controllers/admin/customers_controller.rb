class Admin::CustomersController < Admin::ApplicationController
  # 登録されている会員をID順に取得する
  def index
    @customers = Customer.order(:id)
  end
end