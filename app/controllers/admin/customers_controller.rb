class Admin::CustomersController < Admin::ApplicationController
  # 登録されている会員をID順に取得する
  def index
    @customers = Customer.order(:id)
  end

  # URLのIDに対応する会員を取得する
  def show
    @customer = Customer.find(params[:id])
  end

  # 編集する会員の現在の情報を取得する
  def edit
    @customer = Customer.find(params[:id])
  end

  # 入力された内容で会員情報を更新する
  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # 管理者の編集フォームから更新を許可する項目
  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :phone_number,
      :email_address,
      :is_active
    )
  end
end