class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update]

  def edit
  end

  def update
    if current_user.valid_password?(params[:address][:current_password])
      if @address.update(address_params)
        flash[:success] = "登録情報を変更しました"
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = @address.errors.full_messages
        render action: :edit
      end
    else
      flash.now[:alert] = "パスワードが違います"
      render action: :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:id, :user_id, :prefecture, :city, :building, :postcode)
  end

  def set_address
    @address = current_user.address
  end
end