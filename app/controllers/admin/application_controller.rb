class Admin::ApplicationController < ApplicationController
  # 親から引き継いだ会員用のログイン確認を外す
  skip_before_action :require_authentication, raise: false

  # 管理者専用の認証処理を組み込む
  include Admin::Authentication
end