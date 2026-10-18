class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :customer_state, only: [:create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    redirect_to root_path if authenticated_customer?
  end

  def create
    if customer = Customer.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for customer
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "メールアドレスまたはパスワードが正しくありません"
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def customer_state

    customer = Customer.find_by(email_address: params[:email_address])
    return if customer.nil?
    return unless customer.authenticate(params[:password])

    unless customer.is_active
      redirect_to signup_path
    end
  end
end
