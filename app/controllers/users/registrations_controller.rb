# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def create
    # Userモデルクラスのインスタンスを作成。1ページ目から送られてきたパラメータを@userに代入
    @user = User.new(sign_up_params)
    # バリデーションチェック
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      # フォームに入力した情報をリセットせずに再表示
      render :new and return
    end

    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  def edit
    @user = current_user
  end

  def update
    binding.pry
    # 現在のパスワードが正しいか判定
    if @user.valid_password?(params[:user][:current_password])
      # 「新しいパスワード」と「パスワード（確認）」とが等しいか判定
      if params[:user][:password] == params[:user][:password_confirmation]
        if @user.update(user_params_only_password)
          # パスワード変更後、ログイン状態を維持するため
          sign_in(current_user, bypass: true)
          flash[:success] = "パスワードを変更しました"
          redirect_to user_path(@user)
        else
          flash.now[:alert] = "パスワードを変更できませんでした"
          render action: :edit
        end
      else
        flash.now[:alert] = "新しいパスワード と パスワード（確認）が一致しません"
        render action: :edit
      end
    else
      flash.now[:alert] = "現在のパスワード が正しくありません"
      render action: :edit
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params_only_password
    params.require(:user).permit(:id, :password)
  end

  def address_params
    params.require(:address).permit(:postcode, :prefecture, :city, :building)
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
