module Admin::Authentication
  extend ActiveSupport::Concern

  included do
    # 各アクションの実行前に、管理者のログインを確認する
    before_action :require_admin_authentication

    helper_method :current_admin, :authenticated_admin?
  end

    class_methods do
    # 指定したアクションは、未ログインでも利用できるようにする
    def allow_unauthenticated_access(**options)
      skip_before_action :require_admin_authentication, **options
    end
  end

  private

    # 未ログインの場合は、管理者ログイン画面へ移動する
  def require_admin_authentication
    unless authenticated_admin?
      redirect_to new_admin_session_path
    end
  end

  # 現在のログイン記録から管理者を取得する
  def current_admin
    if Current.admin.nil?
      Current.session = find_admin_session_by_cookie
    end

    Current.admin
  end

  # 管理者を取得できれば、ログイン済みと判断する
  def authenticated_admin?
    current_admin.present?
  end

  # CookieのIDから、管理者用のログイン記録を探す
  def find_admin_session_by_cookie
    session_id = cookies.signed[:admin_session_id]

    if session_id
      Session.where(customer_id: nil)
             .where.not(admin_id: nil)
             .find_by(id: session_id)
    end
  end

    # ログインに成功した管理者の記録とCookieを作る
  def start_new_session_for(admin)
    login_record = admin.sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.remote_ip
    )

    Current.session = login_record

    cookies.signed.permanent[:admin_session_id] = {
      value: login_record.id,
      httponly: true,
      same_site: :lax
    }
  end

  # 現在の管理者のログイン記録とCookieを削除する
  def terminate_session
    if current_admin
      Current.session.destroy
    end

    Current.session = nil
    cookies.delete(:admin_session_id)
  end
end