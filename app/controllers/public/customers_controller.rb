class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:show, :edit, :update]

  def show
    @customer= Current.customer
  end

  def edit
    @customer= Current.customer
  end

  def update
    @customer= Current.customer

    if @customer.update(customer_params)
      redirect_to customer_path(customer.id), notice: "会員情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
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

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == Current.customer
      redirect_to new_session_path, alert:"権限がありません。"
    end
  end  
end