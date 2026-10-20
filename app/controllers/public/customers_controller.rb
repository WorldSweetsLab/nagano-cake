class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update,]
  def show
    @customer = Current.customer
  end

  def edit
    @customer= Customer.find(params[:id])
  end

  def update
    @customer= Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "会員情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def withdraw #退会機能
    @customer = Current.customer
    @customer.update(is_active: false)
    terminate_session
    redirect_to root_path, notice: "退会処理を実行しました。ご利用ありがとうございました。"
  end

  private
  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :email_address, 
      :postal_code,
      :address,
      :phone_number,
      :password, 
      :password_confirmation
    )
  end

  def ensure_correct_customer #ログイン確認メソッド
    @customer = Customer.find(params[:id])
    unless @customer == Current.customer
      redirect_to new_session_path, alert:"権限がありません。"
    end
  end 
end