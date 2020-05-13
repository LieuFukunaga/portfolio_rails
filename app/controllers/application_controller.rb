class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!                                       # ログイン済みのユーザのみにアクセスを許可
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?                             # 本番環境のみにBasic認証を設定


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :tel_num])
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

end