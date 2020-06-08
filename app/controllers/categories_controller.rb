class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_goals, only: [:show, :edit, :update, :destroy]

  def index
    @categories = current_user.categories.order("category_name ASC").page(params[:page]).per(15)
  end

  def show
  end

  def edit
    if @category.user_id != current_user.id
      redirect_to categories_path
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
      flash[:success] = "カテゴリを更新しました"
    else
      flash.now[:alert] = @category.errors.full_messages
      render action: :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: "#{@category.category_name}を削除しました"
    else
      flash.now[:alert] = @category.errors.full_messages
      render categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name, :user_id)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_goals
    @goals = Category.find(params[:id]).goals.where(user_id: current_user.id)
  end

end
