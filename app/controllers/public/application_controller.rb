class Public::ApplicationController < ApplicationController
  include Public::Authentication

  private

  def after_authentication_url
    root_path
  end
end
