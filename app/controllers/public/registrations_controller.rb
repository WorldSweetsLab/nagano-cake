class Public::RegistrationsController < ApplicationController
    allow_unauthenticated_access only: %i[ new create ]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      start_new_session_for @customer
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
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
