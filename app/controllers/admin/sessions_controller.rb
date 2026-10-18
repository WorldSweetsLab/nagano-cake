class Admin::SessionsController < Admin::ApplicationController
  # ログイン画面とログイン処理は、未ログインでも利用できる
  allow_unauthenticated_access only: [:new, :create]

  # ログイン画面を表示する
  def new
    redirect_to admin_top_path if authenticated_admin?
  end

  # メールアドレスとパスワードを照合してログインする
  def create
    if admin = Admin.authenticate_by(
      params.permit(:email_address, :password)
    )
      start_new_session_for(admin)
      redirect_to admin_top_path
    else
      redirect_to new_admin_session_path,
                  alert: "メールアドレスまたはパスワードが正しくありません"
    end
  end

  # ログアウトする
  def destroy
    terminate_session
    redirect_to new_admin_session_path, status: :see_other
  end
end