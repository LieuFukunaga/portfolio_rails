class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :avatar_destroy]

  def show
    @lists = @user.lists

    @tasks = @user.goals
    @done = @tasks.where(status: 0)
    @doing = @tasks.where(status: 1)
  end

  def edit
  end

  def update
    # binding.pry
    if @user.valid_password?(params[:user][:current_password])
      if @user.id == current_user.id
        if @user.update(user_params_except_password)
          flash[:success] = "登録情報を更新しました"
          redirect_to user_path(@user)
        else
          flash.now[:alert] = @goal.errors.full_messages
          render action: :edit
        end
      else
        flash[:alert] = "ログインし直して下さい"
        render new_user_session_path
      end
    else
      flash[:alert] = "パスワードが違います"
      render action: :edit
    end
  end

  def destroy
  end

  def avatar_destroy
    if @user.id == current_user.id && @user.avatar.attached?
      @user.avatar.purge
    else
      render action: :edit
    end
  end


  private
  def user_params_except_password
    params.require(:user).permit(:id, :avatar, :name, :email, :tel_num)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
