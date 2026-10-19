class Public::CustomersController < ApplicationController
  

  def show
    @customer= Customer.find(params[:id])
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


end